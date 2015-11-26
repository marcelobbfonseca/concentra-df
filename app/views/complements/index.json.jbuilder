json.array!(@complements) do |complement|
  json.extract! complement, :id, :name, :cpf, :rg, :photo, :badge_name, :user_id, :je_id
  json.url complement_url(complement, format: :json)
end
