from django.urls import path
from .views import creer_mission, moderer_missions, modifier_utilisateur, supprimer_utilisateur, liste_utilisateurs, missions_valides, valider_missions, moderer_associations, signaler_mission, organisations_valides, valider_associations,  historique_participation, voir_liste_attente, afficher_liste_attente, inscrire_liste_attente, liste_signalements,liste_missions_evaluations, evaluer_mission, statistiques_participation, liste_missions, modifier_mission, supprimer_mission, inscrire_mission, rechercher_missions, api_missions

app_name = 'missions'
urlpatterns = [
    path('missions/', liste_missions, name='liste_missions'),
    path('missions/creer/', creer_mission, name='creer_mission'),
    path('missions/modifier/<int:mission_id>/', modifier_mission, name='modifier_mission'),
    path('missions/supprimer/<int:mission_id>/', supprimer_mission, name='supprimer_mission'),
    path('missions/inscription/<int:mission_id>/', inscrire_mission, name='inscrire_mission'),
    path('missions/recherche/', rechercher_missions, name='rechercher_missions'),
    path('api/missions/', api_missions, name='api_missions'),
    path('statistiques/', statistiques_participation, name='statistiques_participation'),
    path('evaluer/', evaluer_mission, name='evaluer_mission'),
    path('missions/evaluations/', liste_missions_evaluations, name='liste_missions_evaluations'),
    path('signaler/', signaler_mission, name='signaler_mission'),  # URL pour signaler une mission
    path('signalements/', liste_signalements, name='liste_signalements'),  # URL pour voir les signalements
    path('mission/<int:mission_id>/liste-attente/', inscrire_liste_attente, name='liste_attente'),
    path('mission/<int:mission_id>/liste-attente/', afficher_liste_attente, name='liste_attente'),
    path('voir-liste-attente/', voir_liste_attente, name='voir_liste_attente'),
    path('historique_participation/', historique_participation, name='historique_participation'),
    path('valider_associations/', valider_associations, name='valider_associations'),
    path('organisations_valides/', organisations_valides, name='organisations_valides'),
    path('moderer_associations/', moderer_associations, name='moderer_associations'),
    path('moderer_missions/', moderer_missions, name='moderer_missions'),
    path('valider_missions/', valider_missions, name='valider_missions'),
    path('missions_valides/', missions_valides, name='missions_valides'),
    path('liste_utilisateurs/', liste_utilisateurs, name='liste_utilisateurs'),
    path('utilisateur/modifier/<int:user_id>/', modifier_utilisateur, name='modifier_utilisateur'),
    path('utilisateur/supprimer/<int:user_id>/', supprimer_utilisateur, name='supprimer_utilisateur'),
]
