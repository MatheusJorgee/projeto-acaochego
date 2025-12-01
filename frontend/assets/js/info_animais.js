document.addEventListener("DOMContentLoaded", () => {

    const params = new URLSearchParams(window.location.search); //cria uma "nova" url
    const animal = params.get("animal"); 
    const perfis = document.querySelectorAll(".perfil");

    perfis.forEach(perfil => {
        if (!perfil.id.includes(animal)) {
            perfil.style.display = "none";//se não for fica escondido
        } else {
            perfil.style.display = "block";
        }
    });
});
