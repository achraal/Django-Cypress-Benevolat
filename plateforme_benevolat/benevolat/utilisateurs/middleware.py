from django.shortcuts import redirect
from django.urls import reverse
from django.contrib import messages

class LoginRequiredMessageMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        response = self.get_response(request)
        # Si la réponse est une redirection vers la page de login
        login_url = reverse('connexion')
        if (
            response.status_code == 302
            and response['Location'].startswith(login_url)
            and not request.user.is_authenticated
        ):
            messages.warning(request, "Vous devez être connecté pour accéder à cette page.")
        return response
