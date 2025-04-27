from django.shortcuts import render
from django.views import View
from django.http import HttpResponse, HttpResponseRedirect
from .products import products
from .models import Product
from .forms import ProductForm

# Create your views here.
class Home(View):
    def get(self, request):
        return render(request, 'hello.html', {})
    
class ProductList(View):
    def get(self, request):
        products = Product.objects.all()
        return render(request, 'listProducts.html',{'produits':products})
    
class ProductDetail(View):
    def get(self, request, idprod):
        product = Product.objects.get(id=idprod)
        return render(request, 'detailproduct.html', {'product': product})
    
class ProductCreate(View):
    def get(self, request):
        form = ProductForm()
        return render(request, 'productCreate.html', {'form': form})
    def post(self, request):
        form = ProductForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            return HttpResponse('Product created successfully')
        else:
            return render(request, 'productCreate.html', {'form': form})
        
class ProductUpdate(View):
    def get(self, request, id):
        product = Product.objects.get(id=id)
        form = ProductForm(instance=product)
        return render(request, 'productUpdate.html', {'form': form})
    
    def post(self, request, id):
        product = Product.objects.get(id=id)
        form = ProductForm(request.POST, request.FILES, instance=product)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect('/api/products/')
        else:
            return render(request, 'productUpdate.html', {'form': form})

class ProductDelete(View):
    def get(self, request, id):
        product = Product.objects.get(id=id)
        product.delete()
        return HttpResponseRedirect('/api/products/')