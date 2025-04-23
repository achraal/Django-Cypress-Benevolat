from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import login, authenticate, logout
from .forms import InscriptionForm, MessageForm
from django.contrib.auth.decorators import login_required
from .models import Utilisateur, Message, Notification
from .utils import envoyer_notification
from django.db.models import Count
from django.contrib import messages
from django.views.decorators.http import require_POST

def inscription(request):
    if request.method == "POST":
        form = InscriptionForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            return redirect('home')
    else:
        form = InscriptionForm()
    return render(request, 'utilisateurs/inscription.html', {'form': form})

def accueil(request):
    return render(request, 'utilisateurs/accueil.html')

def deconnexion(request):
    logout(request)
    return redirect('home')  # Redirige vers la page d'accueil ou une autre page

@login_required
def envoyer_message(request):
    if request.method == "POST":
        form = MessageForm(request.POST)
        
        if form.is_valid():
            # Récupérer l'instance du formulaire
            message = form.save(commit=False)
            message.expediteur = request.user  # L'utilisateur connecté est l'expéditeur
            message.save()  # Sauvegarder le message dans la base de données

            # Facultatif : Envoyer une notification au destinataire (si tu as une fonction pour cela)
            envoyer_notification(message.destinataire, f"Vous avez reçu un message de {request.user.username}.")
            
            # Message de confirmation
            messages.success(request, "Votre message a bien été envoyé.")

            # Rediriger vers la boîte de réception ou une autre page
            return redirect('boite_reception')
    else:
        form = MessageForm()

    return render(request, "utilisateurs/envoyer_message.html", {
        "form": form
    })


# def envoyer_message(request, destinataire_id):
#     destinataire = get_object_or_404(Utilisateur, id=destinataire_id)

#     if request.method == "POST":
#         contenu = request.POST.get("contenu")
#         Message.objects.create(expediteur=request.user, destinataire=destinataire, contenu=contenu)
#         envoyer_notification(destinataire, f"Vous avez reçu un message de {request.user.username}.")
#         return redirect('boite_reception')

#     return render(request, "utilisateurs/envoyer_message.html", {"destinataire": destinataire})


@login_required
def boite_reception(request):
    messages_recus = Message.objects.filter(destinataire=request.user).order_by('-date_envoye')
    return render(request, "utilisateurs/boite_reception.html", {"messages": messages_recus})

@login_required
def voir_notifications(request):
    notifications = request.user.notifications.all().order_by('-date')
    return render(request, "utilisateurs/notifications.html", {"notifications": notifications})

@login_required
@require_POST
def marquer_notifications_lues(request):
    ids = request.POST.getlist("notifs")
    Notification.objects.filter(id__in=ids, utilisateur=request.user).update(lu=True)
    messages.success(request, f"{len(ids)} notification(s) marquée(s) comme lue(s).")
    return redirect("voir_notifications")


@login_required
def tableau_de_bord(request):
    if request.user.type_utilisateur != 'association':
        return redirect('home')

    missions = request.user.mission_set.all()
    stats = missions.annotate(nb_inscrits=Count('inscrits'))

    return render(request, "utilisateurs/tableau_de_bord.html", {"missions": stats})


# @login_required
# def evaluer_mission(request, mission_id):
#     mission = get_object_or_404(Mission, id=mission_id)

#     # Vérifier si l'utilisateur a déjà évalué la mission
#     if Evaluation.objects.filter(mission=mission, benevole=request.user).exists():
#         messages.error(request, "Vous avez déjà évalué cette mission.")
#         return redirect('missions:liste_missions')

#     # Si l'utilisateur a bien terminé la mission, il peut l'évaluer
#     if request.method == 'POST':
#         form = EvaluationForm(request.POST)
#         if form.is_valid():
#             evaluation = form.save(commit=False)
#             evaluation.mission = mission
#             evaluation.benevole = request.user
#             evaluation.save()
#             messages.success(request, "Votre évaluation a été soumise avec succès.")
#             return redirect('missions:liste_missions')
#     else:
#         form = EvaluationForm()

#     return render(request, 'utilisateur/evaluation.html', {'form': form, 'mission': mission})

# @login_required
# def choisir_mission_a_evaluer(request):
#     if request.method == 'POST':
#         form = EvaluationForm(request.POST)
#         if form.is_valid():
#             mission = form.cleaned_data['mission']
            
#             # Vérifier si l'utilisateur a déjà évalué cette mission
#             if Evaluation.objects.filter(mission=mission, benevole=request.user).exists():
#                 messages.error(request, "Vous avez déjà évalué cette mission.")
#                 return redirect('missions:liste_missions')

#             # Vérifier si la mission a été complétée avant de l'évaluer
#             if not mission.est_terminee:
#                 messages.error(request, "Vous ne pouvez évaluer cette mission que lorsqu'elle est terminée.")
#                 return redirect('missions:liste_missions')

#             # Créer une nouvelle évaluation
#             evaluation = form.save(commit=False)
#             evaluation.benevole = request.user
#             evaluation.save()
#             messages.success(request, "Votre évaluation a été soumise avec succès.")
#             return redirect('missions:liste_missions')
#     else:
#         form = EvaluationForm()

#     return render(request, 'utilisateur/choisir_mission_a_evaluer.html', {'form': form})