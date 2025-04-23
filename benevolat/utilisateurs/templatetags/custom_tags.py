# dans un fichier custom_tags.py
from django import template

register = template.Library()

@register.filter(name='add_class')
def add_class(field, css_class):
    return field.as_widget(attrs={'class': css_class})

@register.filter
def add_classes(field, css_classes):
    return field.as_widget(attrs={'class': css_classes})

@register.simple_tag
def label_tag(field, css_class=''):
    return field.label_tag(attrs={'class': css_class})