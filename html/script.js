let blackmarketItems = {};
let currentCategory = 'weapons';

// Listen for messages from the game client
window.addEventListener('message', function(event) {
    const data = event.data;

    if (data.action === 'open') {
        blackmarketItems = data.items;

        loadItems(currentCategory);
        document.getElementById('blackmarket-container').classList.add('visible');
    }
});

// Load items for a category
function loadItems(category, searchTerm = '') {
    const itemsGrid = document.getElementById('items-grid');
    itemsGrid.innerHTML = '';

    if (!blackmarketItems[category]) return;

    let filteredItems = blackmarketItems[category];

    // Filter items if search term exists
    if (searchTerm) {
        searchTerm = searchTerm.toLowerCase();
        filteredItems = filteredItems.filter(item =>
            item.label.toLowerCase().includes(searchTerm)
        );
    }

    filteredItems.forEach((item, index) => {
        const itemCard = document.createElement('div');
        itemCard.className = 'item-card';
        itemCard.style.animationDelay = `${index * 0.05}s`;

        itemCard.innerHTML = `
            <div class="item-image">
                <img src="assets/${item.image}" alt="${item.label}">
            </div>
            <div class="item-details">
                <div class="item-name">${item.label}</div>
                <div class="item-price">$${item.price.toLocaleString()}</div>
                <button class="buy-button" data-index="${index}">
                    BUY NOW
                </button>
            </div>
        `;

        itemsGrid.appendChild(itemCard);

        // Add event listener to buy button
        const buyButton = itemCard.querySelector('.buy-button');
        buyButton.addEventListener('click', function() {
            const itemIndex = parseInt(this.getAttribute('data-index'));

            // Add visual feedback
            this.style.opacity = '0.7';
            this.textContent = 'BUYING...';

            // Disable button temporarily to prevent multiple clicks
            this.disabled = true;

            buyItem(category, itemIndex, this);
        });
    });

    // Show message if no items found
    if (filteredItems.length === 0) {
        const noItems = document.createElement('div');
        noItems.className = 'no-items';
        noItems.innerHTML = `
            <i class="fas fa-search"></i>
            <p>No items found matching "${searchTerm}"</p>
        `;
        itemsGrid.appendChild(noItems);
    }
}

// Buy item function
function buyItem(category, itemIndex, buttonElement) {
    fetch('https://RaySist-BlackmarketV2/buyItem', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            category: category,
            itemIndex: itemIndex
        })
    })
    .then(response => response.json())
    .then(data => {
        showNotification(data.message);

        // Reset button
        setTimeout(() => {
            if (buttonElement) {
                buttonElement.style.opacity = '1';
                buttonElement.textContent = 'BUY NOW';
                buttonElement.disabled = false;
            }
        }, 1000);
    })
    .catch(error => {
        console.error('Error:', error);
        showNotification('Something went wrong with the purchase.');

        // Reset button on error too
        if (buttonElement) {
            buttonElement.style.opacity = '1';
            buttonElement.textContent = 'BUY NOW';
            buttonElement.disabled = false;
        }
    });
}

// Show notification
function showNotification(message) {
    const notification = document.getElementById('notification');
    const notificationMessage = document.getElementById('notification-message');

    notificationMessage.textContent = message;
    notification.classList.add('show');

    // Add subtle animation
    notification.style.animation = 'none';
    notification.offsetHeight; // Trigger reflow
    notification.style.animation = '';

    setTimeout(() => {
        notification.classList.remove('show');
    }, 3000);
}

// Event listeners
document.addEventListener('DOMContentLoaded', function() {
    // Category switching
    const categories = document.querySelectorAll('.category');
    categories.forEach(category => {
        category.addEventListener('click', function() {
            const categoryName = this.getAttribute('data-category');

            // Update active category
            document.querySelector('.category.active').classList.remove('active');
            this.classList.add('active');

            currentCategory = categoryName;

            // Get search term
            const searchTerm = document.getElementById('search-input').value;
            loadItems(categoryName, searchTerm);
        });
    });

    // Search functionality
    const searchInput = document.getElementById('search-input');
    searchInput.addEventListener('input', function() {
        const searchTerm = this.value;
        loadItems(currentCategory, searchTerm);
    });

    // Close button
    document.getElementById('close-button').addEventListener('click', function() {
        document.getElementById('blackmarket-container').classList.remove('visible');
        setTimeout(() => {
            fetch('https://RaySist-BlackmarketV2/close', {
                method: 'POST'
            });
        }, 300);
    });

    // Close on escape key
    document.addEventListener('keyup', function(event) {
        if (event.key === 'Escape') {
            document.getElementById('close-button').click();
        }
    });

    // Add hover sound effect for buttons
    const buttons = document.querySelectorAll('.buy-button, .category, .close-button');
    buttons.forEach(button => {
        button.addEventListener('mouseenter', () => {
            // You could add a sound effect here if FiveM supports it
        });
    });

    // Add tablet power button effect
    document.querySelector('.tablet-home-button').addEventListener('click', function() {
        document.getElementById('close-button').click();
    });
});

// Add some visual effects
document.addEventListener('DOMContentLoaded', function() {
    // Add parallax effect to item cards
    document.addEventListener('mousemove', function(e) {
        const cards = document.querySelectorAll('.item-card');
        const mouseX = e.clientX / window.innerWidth - 0.5;
        const mouseY = e.clientY / window.innerHeight - 0.5;

        cards.forEach(card => {
            const rect = card.getBoundingClientRect();
            const cardCenterX = rect.left + rect.width / 2;
            const cardCenterY = rect.top + rect.height / 2;

            const distanceX = (e.clientX - cardCenterX) / 30;
            const distanceY = (e.clientY - cardCenterY) / 30;

            const isHovered = card.matches(':hover');

            if (isHovered) {
                card.style.transform = `translateY(-8px) rotateX(${-distanceY}deg) rotateY(${distanceX}deg)`;
                card.style.zIndex = '10';
            } else {
                card.style.transform = '';
                card.style.zIndex = '';
            }
        });
    });

    // Add tablet tilt effect
    document.addEventListener('mousemove', function(e) {
        const tablet = document.querySelector('.tablet-frame');
        const mouseX = e.clientX / window.innerWidth - 0.5;
        const mouseY = e.clientY / window.innerHeight - 0.5;

        tablet.style.transform = `rotateX(${mouseY * 3}deg) rotateY(${-mouseX * 3}deg)`;
    });
});
