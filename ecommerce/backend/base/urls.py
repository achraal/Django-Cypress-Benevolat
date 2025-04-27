from django.urls import path
from . import views

urlpatterns = [
    path('', views.Home.as_view(), name='home'),
    path('products/', views.ProductList.as_view(), name='product'),
    path('products/<int:idprod>/', views.ProductDetail.as_view(), name='products_detail'),
    path('create/', views.ProductCreate.as_view(), name='create'),
    path('product_update/<int:id>', views.ProductUpdate.as_view(), name='product_update'),
    path('product_delete/<int:id>', views.ProductDelete.as_view(), name='product_delete'),
]