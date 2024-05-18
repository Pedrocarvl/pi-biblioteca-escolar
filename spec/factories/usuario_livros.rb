FactoryBot.define do
  factory :usuario_livro do
    association :usuario
    association :livro
  end
end