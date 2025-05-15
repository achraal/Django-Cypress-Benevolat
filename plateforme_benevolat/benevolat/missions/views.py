from django.shortcuts import render, redirect, get_object_or_404
from .models import Mission, ListeAttente, Evaluation, Signalement, HistoriqueParticipation, Utilisateur
from .forms import MissionForm, ValidationMissionForm
from utilisateurs.models import Notification
from .forms import FiltrageMissionForm, EvaluationForm, SignalementForm, ValidationAssociationForm, UtilisateurModificationForm
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib import messages
from utilisateurs.utils import envoyer_notification
from rest_framework.response import Response
from rest_framework.decorators import api_view
from .serializers import MissionSerializer
from django.db.models import Count, Sum, Avg, F, FloatField, ExpressionWrapper


@login_required
def inscrire_mission(request, mission_id):
    mission = get_object_or_404(Mission, id=mission_id)

    if request.user.type_utilisateur != 'benevole':
        messages.error(request, "Seuls les bénévoles peuvent s'inscrire.")
        return redirect('missions:liste_missions')
    
    if mission.inscrits.count() < mission.capacite_max:
        mission.inscrits.add(request.user)
        messages.success(request, f"Vous êtes inscrit à la mission '{mission.titre}'.")
        HistoriqueParticipation.objects.create(utilisateur=request.user, mission=mission)

        # Création de notification pour l'association responsable
        Notification.objects.create(
            utilisateur=mission.association,  # L'association (Utilisateur) responsable de la mission
            message=f"Le bénévole {request.user.username} s'est inscrit à la mission '{mission.titre}'.",
            lu=False,
        )

    else:
        if not ListeAttente.objects.filter(mission=mission, benevole=request.user).exists():
            ListeAttente.objects.create(mission=mission, benevole=request.user)
            messages.info(request, f"Mission complète. Vous avez été ajouté à la liste d'attente pour la mission '{mission.titre}'.")

            # Notification pour l'association que quelqu'un est en liste d'attente
            Notification.objects.create(
                utilisateur=mission.association,
                message=f"Le bénévole {request.user.username} a été ajouté à la liste d'attente pour la mission '{mission.titre}'.",
                lu=False,
            )
        else:
            messages.warning(request, f"Vous êtes déjà inscrit dans la liste d'attente pour la mission '{mission.titre}'.")

    return redirect('missions:liste_missions')


@login_required
def inscrire_liste_attente(request, mission_id):
    # Récupérer la mission par son ID
    mission = get_object_or_404(Mission, id=mission_id)
    utilisateur = request.user  # L'utilisateur actuellement connecté (bénévole)
    
    # Vérifier si l'utilisateur est déjà inscrit dans la liste d'attente
    if ListeAttente.objects.filter(mission=mission, benevole=utilisateur).exists():
        messages.warning(request, "Vous êtes déjà inscrit dans la liste d'attente pour cette mission.")
        return redirect('missions:liste_missions')

    # Inscrire le bénévole dans la liste d'attente
    ListeAttente.objects.create(mission=mission, benevole=utilisateur)
    messages.success(request, f"Vous avez été inscrit dans la liste d'attente pour la mission '{mission.titre}'.")
    
    return redirect('missions:liste_missions')

@login_required
def afficher_liste_attente(request, mission_id):
    mission = get_object_or_404(Mission, id=mission_id)
    liste_attente = ListeAttente.objects.filter(mission=mission).order_by('date_inscription')
    
    return render(request, 'missions/liste_attente.html', {'mission': mission, 'liste_attente': liste_attente})


@login_required
def voir_liste_attente(request):
    if request.user.type_utilisateur != 'association':
        messages.error(request, "Seuls les associations peuvent voir la liste d'attente.")
        return redirect('missions:liste_missions')
    # Récupérer toutes les inscriptions dans la liste d'attente
    liste_attente = ListeAttente.objects.all().order_by('date_inscription')
    
    # Retourner ces informations au template
    return render(request, 'missions/voir_liste_attente.html', {'liste_attente': liste_attente})



    # Vérifier si la mission a encore des places disponibles
    # if mission.places_restantes() > 0:
        # Inscrire directement le bénévole
    #     mission.inscrits.add(request.user)
    #     envoyer_notification(mission.association, f"{request.user.username} s'est inscrit à votre mission {mission.titre}.")
    #     messages.success(request, "Inscription réussie !")
    # else:
        # Ajouter l'utilisateur à la liste d'attente si la mission est complète
        # ListeAttente.objects.get_or_create(mission=mission, benevole=request.user)
        # messages.info(request, "La mission est complète. Vous avez été ajouté à la liste d’attente.")
    
        # Ajouter le bénévole à la liste d'attente si la mission est complète
        # if not ListeAttente.objects.filter(mission=mission, benevole=request.user).exists():
        #     ListeAttente.objects.create(mission=mission, benevole=request.user)
        #     messages.info(request, "La mission est complète, vous êtes sur la liste d'attente.")
        # else:
        #     messages.info(request, "Vous êtes déjà sur la liste d'attente pour cette mission.")

# def liste_attente(request, mission_id):
#     mission = get_object_or_404(Mission, id=mission_id)
#     # liste_attente = ListeAttente.objects.filter(mission=mission).order_by('date_inscription')

    
#     # Récupérer les bénévoles inscrits dans la liste d'attente
#     liste_attente = ListeAttente.objects.filter(mission=mission)
    
#     return render(request, 'missions/liste_attente.html', {
#         'mission': mission,
#         'liste_attente': liste_attente
#     })

    # return render(request, 'missions/liste_attente.html', {'mission': mission, 'liste_attente': liste_attente})

@login_required
def verifier_liste_attente(mission_id, request):
    mission = get_object_or_404(Mission, id=mission_id)

    # Si des places sont disponibles, inscrire les bénévoles en attente
    while mission.inscrits.count() < mission.capacite_max:
        try:
            # Récupère le prochain bénévole en attente
            liste_attente = ListeAttente.objects.filter(mission=mission).order_by('date_inscription').first()
            if liste_attente:
                mission.inscrits.add(liste_attente.benevole)
                # Supprimer le bénévole de la liste d'attente
                liste_attente.delete()
                messages.success(request, f"{liste_attente.benevole.user.username} a été inscrit à la mission.")
            else:
                break
        except IndexError:
            break


@login_required
def creer_mission(request):
    # if not request.user.association.verifie:
    #     messages.error(request, "Votre organisation doit être vérifiée pour créer une mission.")
    #     return redirect('home')  # Redirige vers l'accueil
    if request.user.type_utilisateur != 'association':
        messages.warning(request, "Seuls les associations peuvent créer les missions.")
        return redirect('missions:liste_missions')
    
    if request.method == 'POST':
        form = MissionForm(request.POST, request.FILES)
        if form.is_valid():
            mission = form.save(commit=False)
            mission.association = request.user
            mission.save()
            return redirect('missions:liste_missions')
    else:
        form = MissionForm()
    
    return render(request, 'missions/creer_mission.html', {'form': form})

@login_required
def liste_missions(request):
    form = FiltrageMissionForm(request.GET)
    missions = Mission.objects.all()

    if form.is_valid():
        missions = form.filter_missions()

    return render(request, 'missions/liste_missions.html', {
        'missions': missions,
        'form': form
    })




# def liste_missions(request):
#     form = FiltreMissionForm(request.GET or None)
#     missions = Mission.objects.all().order_by('-urgent', 'date')
#     # missions = Mission.objects.filter(assoc__validee=True)

#     # missions = Mission.objects.all()

#     if form.is_valid():
#         # Filtrer par compétences
#         competences = form.cleaned_data.get('competences')
#         if competences:
#             missions = missions.filter(competences__in=competences).distinct()

#         # Filtrer par disponibilités
#         disponibilites = form.cleaned_data.get('disponibilites')
#         if disponibilites:
#             missions = missions.filter(description__icontains=disponibilites)
#         if request.GET.get('competences'):
#             missions = missions.filter(competences_requises__icontains=request.GET['competences'])

#         if request.GET.get('disponibilites'):
#             missions = missions.filter(disponibilites_requises__icontains=request.GET['disponibilites'])

#     form = FiltreMissionForm(request.GET)

#     return render(request, 'missions/liste_missions.html', {'form': form, 'missions': missions})





# def liste_missions(request):
#     missions = Mission.objects.all()
#     return render(request, 'missions/liste_missions.html', {'missions': missions})

# def liste_missions(request):
#     # Création du formulaire avec la méthode GET
#     form = RechercheMissionForm(request.GET or None)
#     missions = Mission.objects.all()  # Récupère toutes les missions par défaut

#     # Si le formulaire est valide, effectuer la recherche
#     if form.is_valid():
#         recherche = form.cleaned_data.get('recherche')  # Récupère le terme de recherche
#         if recherche:
#             # Filtrer les missions où le titre contient le terme de recherche (insensible à la casse)
#             missions = missions.filter(titre__icontains=recherche)

#     # Retourner la page avec le formulaire et les missions filtrées
#     return render(request, 'missions/liste_missions.html', {'form': form, 'missions': missions})



@login_required
def modifier_mission(request, mission_id):
    mission = get_object_or_404(Mission, id=mission_id)
    if request.user != mission.association:
        messages.warning(request, "Seuls les associations peuvent modifier les missions.")
        return redirect('missions:liste_missions')

    if request.method == 'POST':
        form = MissionForm(request.POST, request.FILES, instance=mission)
        if form.is_valid():
            form.save()
            return redirect('missions:liste_missions')
    else:
        form = MissionForm(instance=mission)

    return render(request, 'missions/modifier_mission.html', {'form': form, 'mission': mission})

@login_required
def supprimer_mission(request, mission_id):
    mission = get_object_or_404(Mission, id=mission_id)
    if request.user == mission.association:
        mission.delete()
    return redirect('missions:liste_missions')

@login_required
def rechercher_missions(request):
    query = request.GET.get('q', '')
    lieu = request.GET.get('lieu', '')
    date = request.GET.get('date', '')

    missions = Mission.objects.all()

    if query:
        missions = missions.filter(titre__icontains=query)
    if lieu:
        missions = missions.filter(lieu__icontains=lieu)
    if date:
        missions = missions.filter(date=date)

    return render(request, 'missions/liste_missions.html', {'missions': missions})

# from .forms import RechercheMissionForm

# def liste_missions(request):
#     form = RechercheMissionForm(request.GET or None)
#     missions = Mission.objects.all()

#     if form.is_valid() and form.cleaned_data.get('recherche'):
#         recherche = form.cleaned_data['recherche']
#         missions = missions.filter(titre__icontains=recherche)

#     return render(request, 'missions/liste_missions.html', {'form': form, 'missions': missions})

@api_view(['GET'])
def api_missions(request):
    missions = Mission.objects.all()
    serializer = MissionSerializer(missions, many=True)
    return Response(serializer.data)

# @login_required
# def statistiques_participation(request):
#     total_missions = Mission.objects.count()
#     total_benevoles = Mission.objects.aggregate(total=Sum('inscrits'))['total'] or 0

#     return render(request, 'missions/statistiques.html', {
#         'total_missions': total_missions,
#         'total_benevoles': total_benevoles
#     })





@login_required
def statistiques_participation(request):
    total_missions = Mission.objects.count()
    total_benevoles = Mission.objects.aggregate(total=Sum('inscrits'))['total'] or 0

    # Nombre de missions urgentes
    missions_urgentes = Mission.objects.filter(urgent=True).count()

    # Capacité totale d’accueil
    capacite_totale = Mission.objects.aggregate(total=Sum('capacite_max'))['total'] or 0

    # Taux de remplissage moyen
    missions = Mission.objects.annotate(
        taux_remplissage=ExpressionWrapper(
            F('inscrits') * 100.0 / F('capacite_max'),
            output_field=FloatField()
        )
    )
    taux_remplissage_moyen = missions.aggregate(moyenne=Avg('taux_remplissage'))['moyenne'] or 0

    # Pour le graphique 1 : bénévoles par mission
    missions_qs = Mission.objects.values('id', 'inscrits')
    noms_missions = [m['id'] for m in missions_qs]
    inscrits = [m['inscrits'] for m in missions_qs]

    # Pour le graphique 2 : missions par catégorie
    missions_par_categorie = Mission.objects.values('categorie').annotate(total=Count('id'))
    labels_categories = [m['categorie'] for m in missions_par_categorie]
    data_categories = [m['total'] for m in missions_par_categorie]

    return render(request, 'missions/statistiques.html', {
        'total_missions': total_missions,
        'total_benevoles': total_benevoles,
        'missions_urgentes': missions_urgentes,
        'capacite_totale': capacite_totale,
        'taux_remplissage_moyen': round(taux_remplissage_moyen, 2),
        'noms_missions': noms_missions,
        'inscrits': inscrits,
        'labels_categories': labels_categories,
        'data_categories': data_categories,
    })


# @login_required
# def statistiques_participation(request):
#     total_missions = Mission.objects.count()
#     total_benevoles = Mission.objects.aggregate(total=Sum('inscrits'))['total'] or 0

#     missions = Mission.objects.values('titre', 'inscrits')

#     noms_missions = [m['titre'] for m in missions]
#     inscrits = [m['inscrits'] for m in missions]

#     return render(request, 'missions/statistiques.html', {
#         'total_missions': total_missions,
#         'total_benevoles': total_benevoles,
#         'noms_missions': noms_missions,
#         'inscrits': inscrits,
#     })



# @login_required
# def signaler(request):
#     if request.method == 'POST':
#         form = SignalementForm(request.POST)
#         if form.is_valid():
#             signalement = form.save(commit=False)
#             signalement.utilisateur = request.user
#             signalement.save()
#             messages.success(request, "Votre signalement a été pris en compte.")
#             return redirect('missions:liste_missions')
#         else:
#             messages.error(request, "Il y a une erreur dans votre signalement.")
#     else:
#         form = SignalementForm()

#     return render(request, 'missions/signaler.html', {'form': form})
@login_required
def evaluer_mission(request):
    if request.method == 'POST':
        form = EvaluationForm(request.POST, utilisateur=request.user)
        if form.is_valid():
            mission = form.cleaned_data['mission']
            note = form.cleaned_data['note']
            commentaire = form.cleaned_data['commentaire']

            # Création de l'évaluation
            Evaluation.objects.create(
                mission=mission,
                benevole=request.user,
                note=note,
                commentaire=commentaire
            )

            messages.success(request, "Évaluation enregistrée avec succès!")
            return redirect('missions:liste_missions')  # Redirection après succès
    else:
        form = EvaluationForm(utilisateur=request.user)

    return render(request, 'missions/evaluation.html', {'form': form})

@login_required
def liste_missions_evaluations(request):
    if request.user.type_utilisateur != 'association':
        messages.warning(request, "Seuls les associations peuvent voir les évaluations.")
        return redirect('missions:liste_missions')
    # Récupérer toutes les missions avec leurs évaluations
    missions = Mission.objects.all()
    
    # Créer un dictionnaire pour chaque mission avec ses évaluations associées
    mission_evaluations = []
    for mission in missions:
        evaluations = mission.evaluation_set.all()  # Récupère les évaluations de chaque mission
        mission_evaluations.append({
            'mission': mission,
            'evaluations': evaluations
        })

    return render(request, 'missions/liste_missions_evaluations.html', {
        'mission_evaluations': mission_evaluations
    })

@login_required
def signaler_mission(request):
    if request.method == 'POST':
        form = SignalementForm(request.POST, utilisateur=request.user)
        if form.is_valid():
            signalement = form.save(commit=False)
            signalement.utilisateur = request.user
            signalement.save()
            messages.success(request, "Votre signalement a été pris en compte.")
            return redirect('missions:liste_missions')
    else:
        form = SignalementForm(utilisateur=request.user)

    return render(request, 'missions/signaler_mission.html', {'form': form})


@login_required
def liste_signalements(request):
    if request.user.type_utilisateur != 'association':
        messages.warning(request, "Seuls les associations peuvent voir les signalements.")
        return redirect('missions:liste_missions')
    # Récupère tous les signalements
    signalements = Signalement.objects.all().select_related('mission', 'utilisateur')

    return render(request, 'missions/liste_signalements.html', {'signalements': signalements})

@login_required
def historique_participation(request):
    participations = HistoriqueParticipation.objects.filter(utilisateur=request.user)
    return render(request, 'missions/historique_participation.html', {'participations': participations})


# @user_passes_test(lambda u: u.is_superuser)  # Assurer que seul un administrateur peut accéder à cette page
# def moderer_associations(request):
#     associations = Association.objects.all()
#     return render(request, 'missions/moderer_associations.html', {'associations': associations})

# Vue pour approuver une organisation
# @user_passes_test(lambda u: u.is_superuser)
# def approuver_association(request, association_id):
#     association = Association.objects.get(id=association_id)
#     association.is_valid = True
#     association.save()
#     return redirect('moderer_associations')

# # Vue pour désapprouver une organisation
# @user_passes_test(lambda u: u.is_superuser)
# def desapprouver_association(request, association_id):
#     association = Association.objects.get(id=association_id)
#     association.is_valid = False
#     association.save()
#     return redirect('moderer_associations')




# @user_passes_test(lambda u: u.is_superuser)  # Assurer que seul un admin peut accéder à cette page
# def valider_associations(request):
#     # Récupérer toutes les associations non validées
#     associations = Utilisateur.objects.filter(user_type='association', is_valid=False)
#     return render(request, 'missions/valider_associations.html', {'associations': associations})

# @user_passes_test(lambda u: u.is_superuser)  # Assurer que seul un admin peut accéder à cette page
# def valider_association(request, user_id):
#     association = get_object_or_404(Utilisateur, id=user_id, user_type='association')
    
#     if request.method == 'POST':
#         form = ValidationAssociationForm(request.POST, instance=association)
#         if form.is_valid():
#             form.save()  # Sauvegarde la validation
#             return redirect('valider_associations')  # Retour à la liste des associations
#     else:
#         form = ValidationAssociationForm(instance=association)

#     return render(request, 'missions/valider_association.html', {'form': form, 'association': association})

@user_passes_test(lambda u: u.is_superuser)  # Assurer que seule un super utilisateur puisse accéder à cette page
def valider_associations(request):
    if request.method == 'POST':
        form = ValidationAssociationForm(request.POST)
        if form.is_valid():
            association = form.cleaned_data['association']  # L'association sélectionnée
            is_valid = form.cleaned_data['is_valid']  # Le statut de validation (True/False)
            # Mettre à jour l'association
            association.is_valid = is_valid
            association.save()
            return redirect('missions:valider_associations')  # Rediriger vers la page de validation après modification
    else:
        form = ValidationAssociationForm()

    return render(request, 'missions/valider_associations.html', {'form': form})

@login_required
def organisations_valides(request):
    # Récupérer toutes les organisations validées (par exemple celles dont is_valid=True)
    associations_valides = Utilisateur.objects.filter(type_utilisateur='association', is_valid=True)
    
    return render(request, 'missions/organisations_valides.html', {'associations_valides': associations_valides})

@user_passes_test(lambda u: u.is_superuser)
def moderer_associations(request):
    # Récupérer toutes les associations non validées (is_valid=False)
    associations_non_validees = Utilisateur.objects.filter(type_utilisateur='association', is_valid=False)
    
    if request.method == 'POST':
        # Récupérer l'id de l'association à valider ou rejeter
        association_id = request.POST.get('association_id')
        action = request.POST.get('action')  # action peut être "valider" ou "rejeter"
        
        try:
            association = Utilisateur.objects.get(id=association_id)
            if action == 'valider':
                association.is_valid = True  # Marquer comme validée
            else:
                association.is_valid = False  # Marquer comme rejetée
            association.save()  # Sauvegarder les modifications
        except Utilisateur.DoesNotExist:
            pass  # L'id de l'association n'existe pas
        
        return redirect('missions:moderer_associations')  # Rediriger vers la même page pour rafraîchir

    return render(request, 'missions/moderer_associations.html', {'associations_non_validees': associations_non_validees})


@user_passes_test(lambda u: u.is_superuser)  # Seuls les super utilisateurs peuvent y accéder
def valider_missions(request):
    if request.method == 'POST':
        form = ValidationMissionForm(request.POST)
        if form.is_valid():
            mission = form.cleaned_data['mission']  # Mission sélectionnée
            is_valid = form.cleaned_data['is_valid']  # Validation ou rejet de la mission
            mission.is_valid = is_valid  # Appliquer le statut
            mission.save()  # Sauvegarder les modifications
            return redirect('missions:valider_missions')  # Rediriger vers la page après modification
    else:
        form = ValidationMissionForm()

    return render(request, 'missions/valider_missions.html', {'form': form})


@login_required
def missions_valides(request):
    # Récupérer toutes les organisations validées (par exemple celles dont is_valid=True)
    missions_valides = Mission.objects.filter(is_valid=True)
    
    return render(request, 'missions/missions_valides.html', {'missions_valides': missions_valides})


@login_required
def moderer_missions(request):
    # Récupérer toutes les missions non validées (par exemple celles qui ont un champ 'is_valid=False')
    missions_non_validees = Mission.objects.filter(is_valid=False)
    
    if request.method == 'POST':
        mission_id = request.POST.get('mission_id')
        action = request.POST.get('action')  # action peut être "valider" ou "rejeter"
        
        try:
            mission = Mission.objects.get(id=mission_id)
            if action == 'valider':
                mission.is_valid = True
            else:
                mission.is_valid = False
            mission.save()  # Sauvegarder les modifications
        except Mission.DoesNotExist:
            pass
        
        return redirect('missions:moderer_missions')  # Rediriger pour rafraîchir

    return render(request, 'missions/moderer_missions.html', {'missions_non_validees': missions_non_validees})

@user_passes_test(lambda u: u.is_superuser)
def liste_utilisateurs(request):
    utilisateurs = Utilisateur.objects.all().order_by('username')  # Tri par username
    return render(request, 'missions/liste_utilisateurs.html', {'utilisateurs': utilisateurs})

@user_passes_test(lambda u: u.is_superuser)
def modifier_utilisateur(request, user_id):
    utilisateur = get_object_or_404(Utilisateur, id=user_id)

    if request.method == 'POST':
        form = UtilisateurModificationForm(request.POST, instance=utilisateur)
        if form.is_valid():
            form.save()
            messages.success(request, f"Utilisateur {utilisateur.username} modifié avec succès.")
            return redirect('missions:liste_utilisateurs')
    else:
        form = UtilisateurModificationForm(instance=utilisateur)

    return render(request, 'missions/modifier_utilisateur.html', {'form': form, 'utilisateur': utilisateur})

@user_passes_test(lambda u: u.is_superuser)
def supprimer_utilisateur(request, user_id):
    utilisateur = get_object_or_404(Utilisateur, id=user_id)

    if request.method == 'POST':
        username = utilisateur.username
        utilisateur.delete()
        messages.success(request, f"Utilisateur {username} supprimé avec succès.")
        return redirect('missions:liste_utilisateurs')

    # Optionnel : page de confirmation avant suppression
    return render(request, 'missions/confirmer_suppression.html', {'utilisateur': utilisateur})
