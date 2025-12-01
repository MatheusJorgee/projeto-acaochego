  // ======= MENU ABRIR/FECHAR (JavaScript) =======

  const menuToggle = document.querySelector(".menu-toggle");
  const menuList = document.querySelector(".menu ul");
  const menuIcon = document.querySelector(".menu-toggle i");

  menuToggle.addEventListener("click", () => {
    // Alterna a visibilidade do Menu
    menuList.classList.toggle("show");

    // ADICIONA A CLASSE 'show' TAMBÉM NO BOTÃO (menuToggle) para a ANIMAÇÃO
    menuToggle.classList.toggle("show");

    // Alterna o ícone (Hamburger <-> X)
    if (menuList.classList.contains("show")) {
      menuIcon.classList.remove("fa-bars");
      menuIcon.classList.add("fa-xmark");
    } else {
      menuIcon.classList.remove("fa-xmark");
      menuIcon.classList.add("fa-bars");
    }
  });