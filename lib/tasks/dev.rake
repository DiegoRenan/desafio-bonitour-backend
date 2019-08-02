namespace :dev do
  desc "Cria passeios a partir do endpoint servidor"
  task setup: :environment do

    puts "Resetando o banco de dados..."
    
    %x(rails db:drop db:create db:migrate)
    
    puts "Buscando attractions no servidor..."

    response = Tour.pull_attractions("https://bonitour-test-api.herokuapp.com/attractions")

    puts "Inserindo Attractions no banco de dados..."
    if response.code == 200
      attractions =  JSON.parse(response.body)
    
      attractions["attractions"].each do |attraction|
        Attraction.create!(
          code: attraction["id"],
          name: attraction["name"],
          duration: attraction["duration"],
          lat: attraction["location"]["lat"],
          long: attraction["location"]["long"],
        )
      end

      puts "Attractions inseridas com sucesso"
    else
      puts "Error ao conectar com o endpoint"
    end

  end

end
