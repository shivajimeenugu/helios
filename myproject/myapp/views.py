from django.shortcuts import render

# Create your views here.
# views.py
from django.shortcuts import render

def notifications(request):
    return render(request, 'notifications.html')
