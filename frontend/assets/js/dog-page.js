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

// ========== CARROSSEL DE IMAGENS ==========
const slider = document.getElementById("dog-slider");
let currentIndex = 0;

// Criar estrutura do carrossel
function criarCarrossel() {
    const temMultiplasImagens = dog.imagens.length > 1;
    
    slider.innerHTML = `
        ${temMultiplasImagens ? `
        <button class="carousel-btn prev" onclick="trocarImagem(-1)">
            <i class="fa-solid fa-chevron-left"></i>
        </button>
        ` : ''}
        
        <div class="carousel-track">
            ${dog.imagens.map((img, index) => `
                <img src="${img}" 
                     class="dog-foto ${index === 0 ? 'active' : ''}" 
                     alt="${dog.nome}">
            `).join('')}
        </div>
        
        ${temMultiplasImagens ? `
        <button class="carousel-btn next" onclick="trocarImagem(1)">
            <i class="fa-solid fa-chevron-right"></i>
        </button>
        
        <div class="carousel-indicators">
            ${dog.imagens.map((_, index) => `
                <span class="indicator ${index === 0 ? 'active' : ''}" 
                      onclick="irParaImagem(${index})"></span>
            `).join('')}
        </div>
        ` : ''}
    `;
}

// Função para trocar imagem
function trocarImagem(direcao) {
    const imagens = slider.querySelectorAll('.dog-foto');
    const indicators = slider.querySelectorAll('.indicator');
    
    // Remove active da imagem atual
    imagens[currentIndex].classList.remove('active');
    indicators[currentIndex].classList.remove('active');
    
    // Calcula novo índice
    currentIndex = (currentIndex + direcao + imagens.length) % imagens.length;
    
    // Adiciona active na nova imagem
    imagens[currentIndex].classList.add('active');
    indicators[currentIndex].classList.add('active');
}

// Função para ir direto para uma imagem específica
function irParaImagem(index) {
    const imagens = slider.querySelectorAll('.dog-foto');
    const indicators = slider.querySelectorAll('.indicator');
    
    imagens[currentIndex].classList.remove('active');
    indicators[currentIndex].classList.remove('active');
    
    currentIndex = index;
    
    imagens[currentIndex].classList.add('active');
    indicators[currentIndex].classList.add('active');
}

// Carrossel automático (opcional - pode remover se não quiser)
let autoSlide = setInterval(() => trocarImagem(1), 4000);

// Pausar carrossel ao passar o mouse
slider.addEventListener('mouseenter', () => clearInterval(autoSlide));
slider.addEventListener('mouseleave', () => {
    autoSlide = setInterval(() => trocarImagem(1), 4000);
});

// Inicializar carrossel
criarCarrossel();

// ========== CARACTERÍSTICAS ==========
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