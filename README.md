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
Essa tarefa vai criar um tabela no banco de dados insirindo os passeios obtidos do Heroku
<code>
    rails dev:setup

</code>
 

<h2>Endpoints</h2>
<hr></hr>

1. Cria um Roteiro inserindo os passeios randomico seguindo o algoritmo da applicação 

<li>
<code>
  POST localhost:3000/v1/create_tour

</code>
</li>
<li>
Headers
<br />
<code>
  Content-Type	application/json
  Accept	application/json

</code>
</li>
<li>
Body
<br />
<code>
  {
    "start_date": "2019-12-06",
    "end_date": "2019-12-09"
  }

</code>
<br />
</li>
<br />

2. Retorna os passeios de um Roteiro 
<li>
<code>
  GET localhost:3000/v1/tours/1/attractions
</code>
</li>
<li>
Headers
<br />
<code>
  Accept	application/json

</code>
</li>
<li>
Body
<br />
<code>
  {
	  "start_date": "2019-12-06",
	  "end_date": "2019-12-09"
  }

</code>
<br />
</li>
<br />

3. Delete um passeio do roteiro 
<li>
<code>
  DELETE localhost:3000/v1/tours/1/attraction/1

</code>
</li>
<li>
Headers
<br />
<code>
  Accept	application/json

</code>
</li>
<li>
Body
<br />
<code>

</code>
</li>
<br />
<br />
4. Insere um passeio no Roteiro

<li>
<code>
  POST localhost:3000/v1/tours/1/attraction
</code>
</li>
<li>
Headers
<br />
<code>
  Content-Type	application/json
  Accept	application/json

</code>
</li>

<li>
Body
<br />
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
<br />
</code>
</li>

<h4>Utilize o link abaixo para testar os endpoints via Postman</h4>
https://www.getpostman.com/collections/6ec7acf4a62255045f7a