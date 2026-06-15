// FiveM Spawn Selector - UI Script

const SpawnSelector = (() => {
    let spawns = [];
    let selectedSpawn = null;
    let filteredSpawns = [];

    const init = () => {
        setupEventListeners();
        showBackgroundOverlay();
        console.log('[Spawn Selector] UI Initialized');
    };

    const setupEventListeners = () => {
        const closeBtn = document.getElementById('close-btn');
        const spawnBtn = document.getElementById('spawn-btn');
        const searchInput = document.getElementById('search-input');
        const bgOverlay = document.getElementById('bg-overlay');

        closeBtn?.addEventListener('click', closeUI);
        bgOverlay?.addEventListener('click', closeUI);
        spawnBtn?.addEventListener('click', () => {
            if (selectedSpawn) {
                spawnPlayer(selectedSpawn.id);
            }
        });
        searchInput?.addEventListener('input', filterSpawns);
        
        // Keyboard shortcuts
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') closeUI();
            if (e.key === 'Enter' && selectedSpawn) spawnPlayer(selectedSpawn.id);
        });
    };

    const openUI = (spawnList) => {
        spawns = spawnList;
        filteredSpawns = [...spawns];
        const container = document.getElementById('spawn-container');
        const bgOverlay = document.getElementById('bg-overlay');
        
        container?.classList.remove('hidden');
        bgOverlay?.classList.remove('hidden');
        renderSpawns(filteredSpawns);
    };

    const closeUI = () => {
        const container = document.getElementById('spawn-container');
        const bgOverlay = document.getElementById('bg-overlay');
        
        container?.classList.add('hidden');
        bgOverlay?.classList.add('hidden');
        selectedSpawn = null;
        
        fetch(`https://${GetParentResourceName()}/closeUI`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({})
        });
    };

    const renderSpawns = (spawnList) => {
        const spawnListContainer = document.getElementById('spawn-list');
        if (!spawnListContainer) return;

        spawnListContainer.innerHTML = '';

        spawnList.forEach((spawn) => {
            const spawnItem = document.createElement('div');
            spawnItem.className = 'spawn-item';
            if (selectedSpawn?.id === spawn.id) {
                spawnItem.classList.add('active');
            }

            spawnItem.innerHTML = `
                <div class="spawn-item-title">${spawn.name}</div>
                <div class="spawn-item-desc">${spawn.description}</div>
            `;

            spawnItem.addEventListener('click', () => selectSpawn(spawn));
            spawnListContainer.appendChild(spawnItem);
        });
    };

    const selectSpawn = (spawn) => {
        selectedSpawn = spawn;
        updateInfo(spawn);
        renderSpawns(filteredSpawns);
    };

    const updateInfo = (spawn) => {
        const titleEl = document.getElementById('info-title');
        const descEl = document.getElementById('info-desc');
        const categoryEl = document.getElementById('info-category');
        const jobEl = document.getElementById('info-job');
        const spawnBtn = document.getElementById('spawn-btn');

        if (titleEl) titleEl.textContent = spawn.name;
        if (descEl) descEl.textContent = spawn.description;
        if (categoryEl) categoryEl.textContent = spawn.name.split(' ')[0];
        if (jobEl) jobEl.textContent = spawn.jobs ? spawn.jobs.join(', ') : 'None';
        if (spawnBtn) {
            spawnBtn.disabled = false;
            spawnBtn.innerHTML = '<span class="btn-text">SPAWN HERE</span><span class="btn-glow"></span>';
        }
    };

    const filterSpawns = (event) => {
        const searchTerm = event.target.value.toLowerCase();
        if (searchTerm === '') {
            filteredSpawns = [...spawns];
        } else {
            filteredSpawns = spawns.filter((spawn) =>
                spawn.name.toLowerCase().includes(searchTerm) ||
                spawn.description.toLowerCase().includes(searchTerm)
            );
        }
        renderSpawns(filteredSpawns);
    };

    const spawnPlayer = (spawnId) => {
        showLoadingScreen();
        fetch(`https://${GetParentResourceName()}/spawnPlayer`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ spawnId })
        })
        .then((response) => response.json())
        .then((data) => {
            setTimeout(() => {
                hideLoadingScreen();
                closeUI();
            }, 2000);
        })
        .catch((error) => {
            console.error('Spawn error:', error);
            hideLoadingScreen();
        });
    };

    const showLoadingScreen = () => {
        const loadingScreen = document.getElementById('loading-screen');
        if (loadingScreen) {
            loadingScreen.classList.remove('hidden');
        }
    };

    const hideLoadingScreen = () => {
        const loadingScreen = document.getElementById('loading-screen');
        if (loadingScreen) {
            loadingScreen.classList.add('hidden');
        }
    };

    const showBackgroundOverlay = () => {
        const bgOverlay = document.getElementById('bg-overlay');
        if (bgOverlay && !bgOverlay.classList.contains('hidden')) {
            bgOverlay.classList.remove('hidden');
        }
    };

    window.addEventListener('message', (event) => {
        const data = event.data;

        if (data.type === 'openSpawner') {
            openUI(data.spawns);
        } else if (data.type === 'playerData') {
            console.log('[Spawn Selector] Player Data:', data.data);
        } else if (data.type === 'setVisible') {
            if (data.visible) {
                document.getElementById('spawn-container')?.classList.remove('hidden');
            } else {
                document.getElementById('spawn-container')?.classList.add('hidden');
            }
        }
    });

    return { init, openUI, closeUI };
})();

document.addEventListener('DOMContentLoaded', () => {
    SpawnSelector.init();
    console.log('[Spawn Selector] DOM Ready');
});
