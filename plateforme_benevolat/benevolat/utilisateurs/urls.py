from django.urls import path
from .views import inscription, accueil, deconnexion, marquer_notifications_lues, envoyer_message, boite_reception, voir_notifications, tableau_de_bord
from django.contrib.auth import views as auth_views
from . import views

# app_name = 'utilisateurs'

urlpatterns = [
    path('', accueil, name='home'),
    path('inscription/', inscription, name='inscription'),
    path('connexion/', auth_views.LoginView.as_view(template_name='utilisateurs/connexion.html'), name='connexion'),
    path('deconnexion/', deconnexion, name='deconnexion'),
    # path('messages/envoyer/<int:destinataire_id>/', envoyer_message, name='envoyer_message'),
    path('messages/envoyer/', envoyer_message, name='envoyer_message'),
    path('messages/', boite_reception, name='boite_reception'),
    path('notifications/', voir_notifications, name='voir_notifications'),
    path('tableau_de_bord/', tableau_de_bord, name='tableau_de_bord'),
    # path('liste_missions/', views.liste_missions, name='liste_missions')
    # path('evaluer/', views.choisir_mission_a_evaluer, name='choisir_mission_a_evaluer'),
    path("notifications/marquer_lues/", marquer_notifications_lues, name="marquer_notifications_lues"),
]
