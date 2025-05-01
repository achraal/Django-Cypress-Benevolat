from django.contrib.auth.models import AbstractUser
from django.db import models
# from missions.models import Mission

class Utilisateur(AbstractUser):
    TYPE_CHOICES = (
        ('benevole', 'Bénévole'),
        ('association', 'Association'),
    )
    type_utilisateur = models.CharField(max_length=20, choices=TYPE_CHOICES)

    is_valid = models.BooleanField(default=False)  

    def __str__(self):
        return self.username

class Message(models.Model):
    expediteur = models.ForeignKey(Utilisateur, on_delete=models.CASCADE, related_name='messages_envoyes')
    destinataire = models.ForeignKey(Utilisateur, on_delete=models.CASCADE, related_name='messages_recus')
    contenu = models.TextField()
    date_envoye = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return f"De {self.expediteur} à {self.destinataire}"

class Notification(models.Model):
    utilisateur = models.ForeignKey(Utilisateur, on_delete=models.CASCADE, related_name='notifications')
    message = models.TextField()
    lu = models.BooleanField(default=False)
    date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.utilisateur.username} - {self.message[:50]}"
    