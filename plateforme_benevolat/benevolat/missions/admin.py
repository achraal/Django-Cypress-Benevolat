# from django.contrib import admin
# from .models import Association

# @admin.register(Association)
# class AssociationAdmin(admin.ModelAdmin):
#     list_display = ('nom', 'email', 'verifie')
#     list_filter = ('verifie',)
#     actions = ['approuver_organisation']

#     def approuver_organisation(self, request, queryset):
#         queryset.update(verifie=True)
#         self.message_user(request, "Les organisations sélectionnées ont été approuvées.")
#     approuver_organisation.short_description = "Approuver les organisations sélectionnées"
