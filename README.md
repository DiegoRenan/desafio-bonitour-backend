# README

<h2>Technology stack</h2>
<hr></hr>

<ul>
    <li>Ruby 2.5.1</li>
    <li>Rails 5.2.3</li>
    <li>sqlite3</li>
</ul>

<h2>Setting up</h2>

1. Baixe ou clone o repositório:
<code>
    git clone https://github.com/DiegoRenan/desafio-bonitour-backend.git <br />
    cd softplan
</code>

2. Instale as dependencias dentro da pasta do 
<code>
    cd desafio-bonitour-backend
    bundle install
</code>

3. Rode as Task Setup para preparar a base de dados da applicação 
<code>
    rails dev:setup
</code>
 Essa tarefa vai criar um tabela no banco de dados insirindo os passeios obtidos do Heroku


<h2>Endpoints</h2>
<hr></hr>

1. Cria um Roteiro inserindo os passeios randomico seguindo o algoritmo da applicação 
<code>
  POST localhost:3000/v1/create_tour
</code>
Headers
<code>
  Content-Type	application/json
  Accept	application/json
</code>
Body
<code>
  {
    "start_date": "2019-12-06",
    "end_date": "2019-12-09"
  }
</code>

2. Retorna os passeios de um Roteiro 
<code>
  GET localhost:3000/v1/tours/1/attractions
</code>
Headers
<code>
  Accept	application/json
</code>
Body
<code>
  {
	  "start_date": "2019-12-06",
	  "end_date": "2019-12-09"
  }
</code>

3. Delete um passeio do roteiro 
<code>
  DELETE localhost:3000/v1/tours/1/attraction/1
</code>
Headers
<code>
  Accept	application/json
</code>
Body
<code>

</code>

4. Insere um passeio no Roteiro
<code>
  POST localhost:3000/v1/tours/1/attraction
</code>
Headers
<code>
  Content-Type	application/json
  Accept	application/json
</code>
Body
<code>
{
    "data": 
    {
        "type": "attraction-tours",
        "attributes": {
            "data": "2019-12-06",
            "checkin": "07:12",
            "attraction_id": 1
        }
    }
}
</code>


https://www.getpostman.com/collections/6ec7acf4a62255045f7a