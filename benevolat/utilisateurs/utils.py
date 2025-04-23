from .models import Notification

def envoyer_notification(utilisateur, message):
    Notification.objects.create(utilisateur=utilisateur, message=message)
