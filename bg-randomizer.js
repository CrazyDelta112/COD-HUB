// Background Image Randomizer / Randomizador de Imagens de Fundo
// Randomly selects 3 images from the jup_ui_sp collection and applies them across all pages / Seleciona aleatoriamente 3 imagens da coleção jup_ui_sp e aplica-as em todas as páginas

(function () {
    const jupImages = [
        'Images/jup_ui_sp_operator_chemical.png',
        'Images/jup_ui_sp_operator_crashsite.png',
        'Images/jup_ui_sp_operator_dam.png',
        'Images/jup_ui_sp_operator_flashback.png',
        'Images/jup_ui_sp_operator_london.png',
        'Images/jup_ui_sp_operator_military.png',
        'Images/jup_ui_sp_operator_oligarch.png',
        'Images/jup_ui_sp_operator_shippingport.png',
        'Images/jup_ui_sp_operator_silo.png',
        'Images/jup_ui_sp_operator_skyhook.png',
        'Images/jup_ui_sp_operator_winterassault.png'
    ];

    function getRandomImages() {
        // Check if we already have selected images in localStorage / Verifica se já temos imagens selecionadas no localStorage
        const stored = localStorage.getItem('codhub_bg_images');
        if (stored) {
            return JSON.parse(stored);
        }

        // Shuffle and pick 3 random images / Embaralha e escolhe 3 imagens aleatórias
        const shuffled = [...jupImages].sort(() => Math.random() - 0.5);
        const selected = shuffled.slice(0, 3);

        // Store for consistency across pages / Armazena para consistência entre páginas
        localStorage.setItem('codhub_bg_images', JSON.stringify(selected));
        return selected;
    }

    function applyBackgroundImages() {
        const images = getRandomImages();
        const bgLeft = document.querySelector('.bg-left');
        const bgCenter = document.querySelector('.bg-center');
        const bgRight = document.querySelector('.bg-right');

        if (bgLeft) bgLeft.src = images[0];
        if (bgCenter) bgCenter.src = images[1];
        if (bgRight) bgRight.src = images[2];
    }

    // Apply images when DOM is ready / Aplica imagens quando o DOM estiver pronto
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', applyBackgroundImages);
    } else {
        applyBackgroundImages();
    }

    // Optional: Add a function to reset/refresh images (can be called from console), DEBUG / Opcional: Adiciona uma função para resetar/atualizar imagens (pode ser chamada do console), DEBUG
    window.refreshBackgroundImages = function () {
        localStorage.removeItem('codhub_bg_images');
        location.reload();
    };
})();
