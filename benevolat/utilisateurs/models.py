from django.contrib.auth.models import AbstractUser
from django.db import models
# from missions.models import Mission

class Utilisateur(AbstractUser):
    TYPE_CHOICES = (
        ('benevole', 'Bénévole'),
        ('association', 'Association'),
    )
    type_utilisateur = models.CharField(max_length=20, choices=TYPE_CHOICES)
    # association = models.ForeignKey('Association', on_delete=models.CASCADE, null=True, blank=True)
    # mission = models.ForeignKey('missions.Mission', on_delete=models.CASCADE)

    is_valid = models.BooleanField(default=False)  # Ajout du champ is_valid

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
    

# class Evaluation(models.Model):
#     mission = models.ForeignKey(Mission, on_delete=models.CASCADE)
#     benevole = models.ForeignKey(Utilisateur, on_delete=models.CASCADE)
#     note = models.PositiveIntegerField(default=0)  # Note de 0 à 5 par exemple
#     commentaire = models.TextField()
#     date_evaluation = models.DateTimeField(auto_now_add=True)

#     def __str__(self):
#         return f"Évaluation de {self.benevole.username} pour {self.mission.titre}"

