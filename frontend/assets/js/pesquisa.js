const searchInput = document.getElementById('search');

searchInput.addEventListener('input', (event) => {
    const value = formatString(event.target.value); //valor do input
    
    const itens = document.querySelectorAll('.grid2 .item2');
    
    itens.forEach(item2 => { //pega o texto que tem dentro do item2
        if(formatString(item2.textContent).indexOf(value) !== -1) {
            item2.style.display = 'flex';
        } else {
            item2.style.display = 'none';
        }
    })
});

function formatString(value){
    return value
    .toLowerCase()
    .trim();
}