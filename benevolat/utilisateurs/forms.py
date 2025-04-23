from django import forms
from django.contrib.auth.forms import UserCreationForm
from .models import Utilisateur, Message

class InscriptionForm(UserCreationForm):
    type_utilisateur = forms.ChoiceField(choices=Utilisateur.TYPE_CHOICES, widget=forms.RadioSelect)

    class Meta:
        model = Utilisateur
        fields = ['username', 'email', 'type_utilisateur', 'password1', 'password2']


class MessageForm(forms.ModelForm):
    destinataire = forms.ModelChoiceField(queryset=Utilisateur.objects.all(), empty_label="Choisissez un destinataire")
    
    class Meta:
        model = Message
        fields = ['destinataire', 'contenu'] 

# class EvaluationForm(forms.ModelForm):
#     class Meta:
#         model = Evaluation
#         fields = ['note', 'commentaire', 'mission']

#     mission = forms.ModelChoiceField(
#         queryset=Mission.objects.filter(est_terminee=True),  # Filtrer par missions terminées
#         empty_label="Choisir une mission",
#         widget=forms.Select(attrs={'class': 'form-control'}))

