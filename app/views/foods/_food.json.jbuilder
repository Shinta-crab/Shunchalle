json.extract! food, :id, :food_name, :category_id, :start_week, :end_week, :most_product_week, :is_rare, :image, :recommend_week, :created_at, :updated_at
json.url food_url(food, format: :json)
