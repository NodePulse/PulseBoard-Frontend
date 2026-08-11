class SubscriptionPlan {
  static const List<Map<String, Object>> plans = [
    {
      "id": "BASIC",
      "name": "Basic",
      "amount": 499,
      "currency": "INR",
      "interval": "month",
      "features": ["3 Projects", "100 Tasks", "5 Team Members"],
    },
    {
      "id": "PREMIUM",
      "name": "Premium",
      "amount": 999,
      "currency": "INR",
      "interval": "month",
      "features": ["10 Projects", "500 Tasks", "20 Team Members"],
    },
    {
      "id": "PRO",
      "name": "Pro",
      "amount": 1499,
      "currency": "INR",
      "interval": "month",
      "features": [
        "Unlimited Projects",
        "Unlimited Tasks",
        "Unlimited Team Members",
      ],
    },
  ];
}
