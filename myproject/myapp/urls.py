from . import consumers
from django.urls import path

urlpatterns = [
    path('ws/notifications/', consumers.NotificationConsumer.as_asgi()),
]