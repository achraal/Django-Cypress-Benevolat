from django.db import models
from utilisateurs.models import Utilisateur

class Mission(models.Model):
    titre = models.CharField(max_length=255)
    description = models.TextField()
    lieu = models.CharField(max_length=255)
    date = models.DateField()
    competences_requises = models.CharField(max_length=255, blank=True, null=True)  
    disponibilites_requises = models.CharField(max_length=255, blank=True, null=True) 
    categorie = models.CharField(max_length=100)
    cause = models.CharField(max_length=100)
    image = models.ImageField(upload_to='missions/', blank=True, null=True)
    document = models.FileField(upload_to='missions/docs/', blank=True, null=True)
    association = models.ForeignKey(Utilisateur, on_delete=models.CASCADE, limit_choices_to={'type_utilisateur': 'association'})
    capacite_max = models.PositiveIntegerField(default=10) 
    inscrits = models.ManyToManyField(Utilisateur, related_name='missions_inscrites', blank=True)
    urgent = models.BooleanField(default=False)
    is_valid = models.BooleanField(default=False) 
    date_creation = models.DateTimeField(auto_now_add=True)

    
    def places_restantes(self):
        return self.capacite_max - self.inscrits.count()

    def __str__(self):
        return self.titre



# class Association(models.Model):
#     nom = models.CharField(max_length=255)
#     email = models.EmailField(unique=True)
#     description = models.TextField()
#     verifie = models.BooleanField(default=False)  # Ajout de la vérification

#     def __str__(self):
#         return self.nom

# enlever
class Competence(models.Model):
    nom = models.CharField(max_length=100)
    
    def __str__(self):
        return self.nom

# enlever
class Benevole(models.Model):
    user = models.OneToOneField(Utilisateur, on_delete=models.CASCADE)
    competences = models.ManyToManyField(Competence, related_name="benevoles")
    disponibilites = models.CharField(max_length=200) 

class ListeAttente(models.Model):
    mission = models.ForeignKey(Mission, on_delete=models.CASCADE)
    benevole = models.ForeignKey(Utilisateur, on_delete=models.CASCADE)
    date_inscription = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('mission', 'benevole')


    def __str__(self):
        return f"{self.benevole.user.username} en attente pour {self.mission.titre}"
    
# class Signalement(models.Model):
#     TYPE_CHOICES = [
#         ('mission', 'Mission'),
#         ('benevole', 'Bénévole'),
#         # Tu peux ajouter d'autres types selon les besoins
#     ]
    
#     utilisateur = models.ForeignKey(Utilisateur, on_delete=models.CASCADE)
#     mission = models.ForeignKey('Mission', on_delete=models.CASCADE, null=True, blank=True)
#     type_signalement = models.CharField(max_length=20, choices=TYPE_CHOICES)
#     description = models.TextField()
#     date_signalement = models.DateTimeField(auto_now_add=True)
#     statut = models.CharField(max_length=20, default='en cours', choices=[('en cours', 'En cours'), ('résolu', 'Résolu')])

#     def __str__(self):
#         return f"Signalement de {self.utilisateur.username} pour {self.type_signalement}"


# class Association(models.Model):
#     nom = models.CharField(max_length=100)
#     description = models.TextField()
#     validee = models.BooleanField(default=False)  # Ajout

class Evaluation(models.Model):
    mission = models.ForeignKey(Mission, on_delete=models.CASCADE)
    benevole = models.ForeignKey(Utilisateur, on_delete=models.CASCADE)
    note = models.IntegerField()
    commentaire = models.TextField()
    date = models.DateTimeField(auto_now_add=True)

class Signalement(models.Model):
    mission = models.ForeignKey(Mission, on_delete=models.CASCADE)
    utilisateur = models.ForeignKey(Utilisateur, on_delete=models.CASCADE)
    motif = models.TextField()
    date_signalement = models.DateTimeField(auto_now_add=True)
    
    
    def __str__(self):
        return f"Signalement de {self.utilisateur} pour la mission {self.mission}"

class HistoriqueParticipation(models.Model):
    utilisateur = models.ForeignKey(Utilisateur, on_delete=models.CASCADE)
    mission = models.ForeignKey(Mission, on_delete=models.CASCADE)
    date_participation = models.DateTimeField(auto_now_add=True)
    utilisateur = models.ForeignKey(Utilisateur, on_delete=models.CASCADE)

# enlever
class Association(models.Model):
    nom = models.CharField(max_length=100)
    description = models.TextField()
    is_valid = models.BooleanField(default=False)  # Champ de validation
    date_creation = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.nom
