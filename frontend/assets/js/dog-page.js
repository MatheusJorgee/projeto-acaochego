const params = new URLSearchParams(window.location.search);
const id = params.get("id");

const dog = cachorros[id];

if (!dog) {
    document.body.innerHTML = "<h1>Cachorro não encontrado!</h1>";
}

document.getElementById("dog-name").textContent = dog.nome;
document.getElementById("dog-subtitle").textContent = dog.subtitle;

document.getElementById("t-nome").textContent = dog.nome;
document.getElementById("t-idade").textContent = dog.idade;
document.getElementById("t-raca").textContent = dog.raca;
document.getElementById("t-porte").textContent = dog.porte;
document.getElementById("t-sexo").textContent = dog.sexo;
document.getElementById("t-local").textContent = dog.local;

const slider = document.getElementById("dog-slider");

const primeiraImagem = dog.imagens[0];

slider.innerHTML = `<img src="${primeiraImagem}" class="dog-foto">`;

const container = document.getElementById("dog-caracteristicas");
container.innerHTML = dog.caracteristicas
    .map(c => `
        <div class="cartao">
            <div class="conteudo-superior">
                <i class="fa-solid ${c.icone}"></i>
                <h3>${c.titulo}</h3>
                <p>${c.texto}</p>
            </div>
        </div>
    `)
    .join("");

    let currentIndex = 0;

const imagensLista = document.getElementById("dog-imagens-lista");

imagensLista.innerHTML = dog.imagens
    .map(img => `
        <li class="item2 cartao-imagem">
            <img src="${img}" alt="${dog.nome}">
        </li>
    `)
    .join("");
 