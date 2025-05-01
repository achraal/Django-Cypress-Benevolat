from django import forms
from .models import Mission, Signalement, Association, Utilisateur
from django.contrib.auth.hashers import make_password


# class MissionForm(forms.ModelForm):
#     class Meta:
#         model = Mission
#         fields = ['titre', 'description', 'lieu', 'date', 'competences_requises', 'categorie', 'cause', 'image', 'document']


class MissionForm(forms.ModelForm):
    class Meta:
        model = Mission
        fields = ['titre', 'description', 'lieu', 'date', 'competences_requises', 'disponibilites_requises', 'categorie', 'cause', 'image', 'document', 'urgent', 'capacite_max']



# class RechercheMissionForm(forms.Form):
#     recherche = forms.CharField(max_length=100, required=False, label='Rechercher une mission')
# class RechercheMissionForm(forms.Form):
#     recherche = forms.CharField(required=False, label='Rechercher une mission')



# class FiltreMissionForm(forms.Form):
#     competences = forms.ModelMultipleChoiceField(queryset=Competence.objects.all(), required=False)
#     disponibilites = forms.CharField(max_length=200, required=False, label="Disponibilités")


# class SignalementForm(forms.ModelForm):
#     class Meta:
#         model = Signalement
#         fields = ['type_signalement', 'mission', 'description']
#         widgets = {
#             'description': forms.Textarea(attrs={'rows': 4}),
#         }

#     def __init__(self, *args, **kwargs):
#         super().__init__(*args, **kwargs)
#         # Si le signalement concerne une mission, il faut s'assurer que l'utilisateur l'ait choisi
#         if self.instance and self.instance.type_signalement == 'mission':
#             self.fields['mission'].required = True
#         else:
#             self.fields['mission'].required = False
# forms.py

class EvaluationForm(forms.Form):
    mission = forms.ModelChoiceField(queryset=Mission.objects.none(), label="Sélectionner une mission")
    note = forms.IntegerField(min_value=1, max_value=5, label="Note (1 à 5)")
    commentaire = forms.CharField(widget=forms.Textarea, label="Commentaire", required=False)

    def __init__(self, *args, **kwargs):
        utilisateur = kwargs.pop('utilisateur', None)
        super().__init__(*args, **kwargs)
        if utilisateur:
            self.fields['mission'].queryset = Mission.objects.filter(inscrits=utilisateur)

class FiltrageMissionForm(forms.Form):
    competences = forms.CharField(max_length=255, required=False, label="Compétences requises")
    disponibilites = forms.CharField(max_length=255, required=False, label="Disponibilités requises")
    urgent = forms.BooleanField(required=False, label="Mission urgente", initial=False)

    def filter_missions(self):
        competences = self.cleaned_data['competences']
        disponibilites = self.cleaned_data['disponibilites']
        urgent = self.cleaned_data['urgent']
        
        missions = Mission.objects.all()

        if competences:
            missions = missions.filter(competences_requises__icontains=competences)
        if disponibilites:
            missions = missions.filter(disponibilites_requises__icontains=disponibilites)
        if urgent:
            missions = missions.filter(urgent=True)

        return missions

class SignalementForm(forms.ModelForm):
    mission = forms.ModelChoiceField(
        queryset=Mission.objects.none(),  # Par défaut vide, on remplit dynamiquement
        empty_label="Choisir une mission",
        widget=forms.Select(attrs={'class': 'form-control'})
    )
    motif = forms.CharField(
        widget=forms.Textarea(attrs={'class': 'form-control', 'rows': 3}),
        label="Motif du signalement"
    )

    class Meta:
        model = Signalement
        fields = ['mission', 'motif']

    def __init__(self, *args, **kwargs):
        utilisateur = kwargs.pop('utilisateur', None)
        super().__init__(*args, **kwargs)
        if utilisateur and utilisateur.type_utilisateur == 'benevole':
            # Filtrer les missions où le bénévole est inscrit
            self.fields['mission'].queryset = Mission.objects.filter(inscrits=utilisateur)
        else:
            # Pour les autres types d'utilisateur, on peut afficher toutes les missions ou aucune
            self.fields['mission'].queryset = Mission.objects.none()



# class SignalementForm(forms.ModelForm):
#     class Meta:
#         model = Signalement
#         fields = ['mission', 'motif']  # Nous permettons à l'utilisateur de choisir la mission et de fournir un motif

#     mission = forms.ModelChoiceField(queryset=Mission.objects.all(), empty_label="Choisir une mission", widget=forms.Select(attrs={'class': 'form-control'}))
#     motif = forms.CharField(widget=forms.Textarea(attrs={'class': 'form-control', 'rows': 3}), label="Motif du signalement")

# class ValidationAssociationForm(forms.ModelForm):
#     class Meta:
#         model = Association
#         fields = ['is_valid']  # Seulement le champ pour la validation

#     is_valid = forms.BooleanField(required=False, label="Valider l'association")

# class ValidationAssociationForm(forms.ModelForm):
#     class Meta:
#         model = Utilisateur
#         fields = ['is_valid']  # Seulement le champ pour la validation
    
#     is_valid = forms.BooleanField(required=False, label="Valider cette association")


class ValidationAssociationForm(forms.Form):
    association = forms.ModelChoiceField(
        queryset=Utilisateur.objects.filter(type_utilisateur='association', is_valid=False),  # Remplacer 'user_type' par 'type_utilisateur'
        empty_label="Sélectionnez une association",  # Texte affiché si rien n'est sélectionné
        to_field_name="username",  # Utiliser le champ `username` pour afficher les associations
        widget=forms.Select(attrs={'class': 'form-control'}),
    )
    is_valid = forms.BooleanField(required=False, label="Valider l'association")

class ValidationMissionForm(forms.Form):
    mission = forms.ModelChoiceField(
        queryset=Mission.objects.filter(is_valid=False),  # Missions non validées
        empty_label="Sélectionnez une mission",
        widget=forms.Select(attrs={'class': 'form-control'})
    )
    is_valid = forms.BooleanField(required=False, label="Valider la mission")


class UtilisateurModificationForm(forms.ModelForm):
    password = forms.CharField(
        label="Nouveau mot de passe",
        required=False,
        widget=forms.PasswordInput(render_value=False),
        help_text="Laissez vide pour ne pas modifier le mot de passe."
    )

    class Meta:
        model = Utilisateur
        fields = ['username', 'email', 'password']

    def clean_password(self):
        password = self.cleaned_data.get('password')
        if password:
            # Vous pouvez ajouter ici des validations de mot de passe si besoin
            return make_password(password)  # Hash du mot de passe
        return None

    def save(self, commit=True):
        utilisateur = super().save(commit=False)
        password = self.cleaned_data.get('password')
        if password:
            utilisateur.password = password  # password déjà hashé dans clean_password
        if commit:
            utilisateur.save()
        return utilisateur
