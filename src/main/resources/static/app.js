let currentPage = 1;
const pageSize = 10;
let paginationData = null;

async function fetchBooks(page = currentPage){
  currentPage = page;
  const res = await fetch(`/api/books?page=${page}&size=${pageSize}`);
  const data = await res.json();
  paginationData = data;
  renderTable(data.content || data);
  renderPagination(data);
}

function renderTable(books){
  const tbody = document.getElementById('tbody');
  tbody.innerHTML = '';
  for (const b of books){
    const tr = document.createElement('tr');
    tr.innerHTML = `
      <td>${escapeHtml(b.id)}</td>
      <td>${escapeHtml(b.name||'')}</td>
      <td>${escapeHtml(b.author||'')}</td>
      <td>${escapeHtml(b.isbn||'')}</td>
      <td>${escapeHtml(b.category||'')}</td>
      <td><input data-id="${b.id}" data-field="inventory" data-original="${b.inventory}" type="number" class="cell-input" value="${Number(b.inventory)}"></td>
      <td><input data-id="${b.id}" data-field="price" data-original="${b.price}" type="number" step="0.01" class="cell-input" value="${Number(b.price)}"></td>
      <td><button data-id="${b.id}" data-action="save" class="btn secondary" disabled>Save</button></td>
    `;
    tbody.appendChild(tr);
  }

  // enable/disable Save per row
  tbody.querySelectorAll('tr').forEach(row => {
    const saveBtn = row.querySelector('button[data-action="save"]');
    const inputs = row.querySelectorAll('input[data-id]');
    const updateSaveState = () => {
      const changed = Array.from(inputs).some(inp => String(inp.value) !== String(inp.dataset.original));
      saveBtn.disabled = !changed;
      saveBtn.classList.toggle('secondary', !changed);
    };
    inputs.forEach(inp => inp.addEventListener('input', updateSaveState));
    updateSaveState();
  });

  // Save handler per row
  tbody.querySelectorAll('button[data-action="save"]').forEach(btn=>{
    btn.addEventListener('click', async ()=>{
      const id = btn.dataset.id;
      const invInput = tbody.querySelector(`input[data-id="${id}"][data-field="inventory"]`);
      const priceInput = tbody.querySelector(`input[data-id="${id}"][data-field="price"]`);

      const invChanged = String(invInput.value) !== String(invInput.dataset.original);
      const priceChanged = String(priceInput.value) !== String(priceInput.dataset.original);

      if (!invChanged && !priceChanged) {
        setStatus('No changes to save');
        return;
      }

      setStatus('Saving…');
      const requests = [];

      if (invChanged) {
        const inventory = Number(invInput.value);
        requests.push(fetch(`/api/books/${id}/inventory`, {
          method: 'PUT',
          headers: {'Content-Type':'application/json'},
          body: JSON.stringify({ inventory })
        }));
      }

      if (priceChanged) {
        const price = Number(priceInput.value);
        requests.push(fetch(`/api/books/${id}/price`, {
          method: 'PUT',
          headers: {'Content-Type':'application/json'},
          body: JSON.stringify({ price })
        }));
      }

      // Execute only the necessary calls
      const results = await Promise.all(requests);
      const ok = results.every(r => r.ok);

      setStatus(ok ? 'Saved ✓' : 'Save failed');

      if (ok) {
        await fetchBooks(currentPage); // refresh current page
      } else {
        try {
          const err = await results.find(r=>!r.ok).json();
          setStatus(err && err.error ? err.error : 'Save failed');
        } catch(e){}
      }
    });
  });
}

// ------------- session-based user management -------------
let currentUser = null;

async function loadCurrentUser(){
  try {
    const response = await fetch('/api/session');
    const data = await response.json();
    
    if (data.authenticated && data.user) {
      currentUser = data.user;
      renderUserUI();
    } else {
      // No valid session, redirect to welcome
      window.location.href = '/welcome';
    }
  } catch (error) {
    console.error('Failed to load user session:', error);
    window.location.href = '/welcome';
  }
}

function renderUserUI(){
  const chip = document.getElementById('user-chip');
  if (!chip || !currentUser) return;

  chip.textContent = `@${currentUser.username}`;
}

// Logout functionality
const logoutBtn = document.getElementById('logout-btn');
if (logoutBtn){
  logoutBtn.addEventListener('click', async ()=>{
    try {
      await fetch('/api/logout', { method: 'POST' });
      window.location.href = '/welcome';
    } catch (error) {
      console.error('Logout error:', error);
      // Force redirect even if logout call fails
      window.location.href = '/welcome';
    }
  });
}

// ------------- misc helpers -------------
function escapeHtml(s){
  if (s == null) return '';
  return String(s)
    .replaceAll('&','&amp;')
    .replaceAll('<','&lt;')
    .replaceAll('>','&gt;')
    .replaceAll('"','&quot;')
    .replaceAll("'",'&#039;');
}

function setStatus(t){
  const el = document.getElementById('status');
  el.textContent=t;
  if (t) { setTimeout(()=>{ el.textContent=''; }, 2500); }
}

// ------------- pagination handlers -------------
document.getElementById('refresh').addEventListener('click', () => fetchBooks(currentPage));
document.getElementById('prev-page').addEventListener('click', () => {
  if (currentPage > 1) {
    fetchBooks(currentPage - 1);
  }
});
document.getElementById('next-page').addEventListener('click', () => {
  if (paginationData && paginationData.hasNext) {
    fetchBooks(currentPage + 1);
  }
});

function renderPagination(data) {
  if (!data || data.totalItems === undefined) {
    // Fallback for backward compatibility
    const count = (data && Array.isArray(data) ? data.length : 0);
    document.getElementById('pagination-info').textContent = `Showing ${count} books`;
    document.getElementById('prev-page').disabled = true;
    document.getElementById('next-page').disabled = true;
    document.getElementById('page-numbers').innerHTML = '';
    return;
  }

  const startItem = data.currentPage === 1 ? 1 : (data.currentPage - 1) * data.pageSize + 1;
  const endItem = Math.min(data.currentPage * data.pageSize, data.totalItems);
  
  document.getElementById('pagination-info').textContent = 
    `Showing ${startItem} - ${endItem} of ${data.totalItems} books`;
  
  document.getElementById('prev-page').disabled = !data.hasPrevious;
  document.getElementById('next-page').disabled = !data.hasNext;
  
  // Render page numbers
  const pageNumbers = document.getElementById('page-numbers');
  pageNumbers.innerHTML = '';
  
  const maxPagesToShow = 7;
  let startPage = Math.max(1, data.currentPage - Math.floor(maxPagesToShow / 2));
  let endPage = Math.min(data.totalPages, startPage + maxPagesToShow - 1);
  
  if (endPage - startPage < maxPagesToShow - 1) {
    startPage = Math.max(1, endPage - maxPagesToShow + 1);
  }
  
  if (startPage > 1) {
    const firstBtn = document.createElement('button');
    firstBtn.className = 'page-btn';
    firstBtn.textContent = '1';
    firstBtn.addEventListener('click', () => fetchBooks(1));
    pageNumbers.appendChild(firstBtn);
    
    if (startPage > 2) {
      const ellipsis = document.createElement('span');
      ellipsis.className = 'page-ellipsis';
      ellipsis.textContent = '...';
      pageNumbers.appendChild(ellipsis);
    }
  }
  
  for (let i = startPage; i <= endPage; i++) {
    const pageBtn = document.createElement('button');
    pageBtn.className = 'page-btn';
    if (i === data.currentPage) {
      pageBtn.className += ' active';
    }
    pageBtn.textContent = i.toString();
    pageBtn.addEventListener('click', () => fetchBooks(i));
    pageNumbers.appendChild(pageBtn);
  }
  
  if (endPage < data.totalPages) {
    if (endPage < data.totalPages - 1) {
      const ellipsis = document.createElement('span');
      ellipsis.className = 'page-ellipsis';
      ellipsis.textContent = '...';
      pageNumbers.appendChild(ellipsis);
    }
    
    const lastBtn = document.createElement('button');
    lastBtn.className = 'page-btn';
    lastBtn.textContent = data.totalPages.toString();
    lastBtn.addEventListener('click', () => fetchBooks(data.totalPages));
    pageNumbers.appendChild(lastBtn);
  }
}

// ------------- boot -------------
loadCurrentUser();
fetchBooks(1);