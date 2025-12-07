document.addEventListener("DOMContentLoaded", () => {
  // 1. Configuração Inicial e Carregamento de Dados
  const params = new URLSearchParams(window.location.search);
  const dogKey = params.get("dog") || "nanda"; // Assume 'nanda' como padrão

  // Verifica se o objeto cachorros está definido e se o cão existe
  if (typeof cachorros === "undefined" || !cachorros[dogKey]) {
    console.error("Dados do cachorro não carregados ou cão não encontrado.");
    document.getElementById("dog-name").textContent =
      "Cachorro não encontrado.";
    return;
  }

  const dog = cachorros[dogKey];

  // 2. Preenchimento dos Dados da Página
  document.getElementById("dog-name").textContent = dog.nome;
  document.getElementById("dog-subtitle").textContent = dog.subtitle || "";
  document.getElementById("dog-description").textContent =
    dog.descricao ||
    "Este cão está esperando para contar a você a sua história. Entre em contato para saber mais!";

  // Preenchendo a grade de detalhes
  document.getElementById("t-nome").textContent = dog.nome;
  document.getElementById("t-idade").textContent = dog.idade;
  document.getElementById("t-raca").textContent = dog.raca;
  document.getElementById("t-porte").textContent = dog.porte;
  document.getElementById("t-sexo").textContent = dog.sexo;
  document.getElementById("t-local").textContent = dog.local;

  // Preenchendo as características (cartões)
  const caracteristicasContainer = document.getElementById(
    "dog-caracteristicas"
  );
  caracteristicasContainer.innerHTML = "";
  dog.caracteristicas.forEach((c) => {
    const cartao = document.createElement("div");
    cartao.className = "cartao";
    cartao.innerHTML = `
      <div class="conteudo-superior">
          <i class="fa-solid ${c.icone}"></i>
          <h3>${c.titulo}</h3>
      </div>
      <p>${c.texto}</p>
    `;
    caracteristicasContainer.appendChild(cartao);
  });

  // 3. CRIAÇÃO E LÓGICA DO CARROSSEL
  const sliderContainer = document.getElementById("dog-slider");
  let currentIndex = 0;
  const totalImages = dog.imagens.length;

  // Se só houver uma imagem, não cria botões nem dots
  if (totalImages <= 1) {
    const img = document.createElement("img");
    img.src = dog.imagens[0];
    img.alt = `Foto de ${dog.nome}`;
    img.className = "slider-image";
    sliderContainer.appendChild(img);
    return;
  }

  // Cria o wrapper que conterá todas as imagens para deslizar
  const sliderWrapper = document.createElement("div");
  sliderWrapper.className = "slider-wrapper";

  // Cria o container para os pontos de navegação (dots)
  const dotsContainer = document.createElement("div");
  dotsContainer.className = "slider-dots";

  // Insere as imagens e cria os pontos (dots)
  dog.imagens.forEach((src, index) => {
    const img = document.createElement("img");
    img.src = src;
    img.alt = `Foto ${index + 1} de ${dog.nome}`;
    img.className = "slider-image";
    sliderWrapper.appendChild(img);

    const dot = document.createElement("span");
    dot.className = index === 0 ? "dot active" : "dot";
    dot.addEventListener("click", () => {
      currentIndex = index;
      updateSlider();
      stopAutoSlide();
      startAutoSlide();
    });
    dotsContainer.appendChild(dot);
  });

  sliderContainer.appendChild(sliderWrapper);
  sliderContainer.appendChild(dotsContainer);

  // Função para atualizar a exibição do carrossel
  function updateSlider() {
    const offset = -currentIndex * 100;
    sliderWrapper.style.transform = `translateX(${offset}%)`;

    document.querySelectorAll(".dot").forEach((dot, index) => {
      dot.classList.remove("active");
      if (index === currentIndex) {
        dot.classList.add("active");
      }
    });
  }

  // Botões de navegação
  const prevButton = document.createElement("button");
  prevButton.className = "slider-button prev-button";
  prevButton.innerHTML = '<i class="fa-solid fa-chevron-left"></i>';
  prevButton.onclick = () => {
    currentIndex = currentIndex > 0 ? currentIndex - 1 : totalImages - 1;
    updateSlider();
    stopAutoSlide();
    startAutoSlide();
  };

  const nextButton = document.createElement("button");
  nextButton.className = "slider-button next-button";
  nextButton.innerHTML = '<i class="fa-solid fa-chevron-right"></i>';
  nextButton.onclick = () => {
    currentIndex = currentIndex < totalImages - 1 ? currentIndex + 1 : 0;
    updateSlider();
    stopAutoSlide();
    startAutoSlide();
  };

  sliderContainer.appendChild(prevButton);
  sliderContainer.appendChild(nextButton);

  // 4. FUNCIONALIDADE DE CARROSSEL AUTOMÁTICO
  const intervalTime = 5000;
  let autoSlideInterval;

  const nextSlide = () => {
    currentIndex = currentIndex < totalImages - 1 ? currentIndex + 1 : 0;
    updateSlider();
  };

  const startAutoSlide = () => {
    if (autoSlideInterval) clearInterval(autoSlideInterval);
    autoSlideInterval = setInterval(nextSlide, intervalTime);
  };

  const stopAutoSlide = () => {
    clearInterval(autoSlideInterval);
  };

  startAutoSlide();

  sliderContainer.addEventListener("mouseenter", stopAutoSlide);
  sliderContainer.addEventListener("mouseleave", startAutoSlide);

  updateSlider();
});
