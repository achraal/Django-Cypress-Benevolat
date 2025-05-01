def notifications_non_lues(request):
    if request.user.is_authenticated:
        nb_non_lues = request.user.notifications.filter(lu=False).count()
    else:
        nb_non_lues = 0
    return {
        'nb_notifications_non_lues': nb_non_lues
    }