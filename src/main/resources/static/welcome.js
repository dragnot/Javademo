// Welcome page functionality
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('welcome-form');
    const loginBtn = document.getElementById('login-btn');
    const statusDiv = document.getElementById('status');
    
    // Check if user is already logged in
    checkExistingSession();
    
    form.addEventListener('submit', async function(e) {
        e.preventDefault();
        
        const username = document.getElementById('username').value.trim();
        const firstName = document.getElementById('firstName').value.trim();
        const lastName = document.getElementById('lastName').value.trim();
        
        if (!username) {
            showStatus('Username is required', 'error');
            return;
        }
        
        // Disable button and show loading
        loginBtn.disabled = true;
        loginBtn.textContent = 'Setting up your session...';
        
        try {
            const response = await fetch('/api/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    username: username,
                    firstName: firstName,
                    lastName: lastName
                })
            });
            
            const data = await response.json();
            
            if (response.ok && data.success) {
                showStatus(`Welcome, ${data.username}! Redirecting...`, 'success');
                setTimeout(() => {
                    window.location.href = '/books';
                }, 1500);
            } else {
                showStatus(data.error || 'Login failed', 'error');
                resetButton();
            }
        } catch (error) {
            console.error('Login error:', error);
            showStatus('Network error. Please try again.', 'error');
            resetButton();
        }
    });
    
    function resetButton() {
        loginBtn.disabled = false;
        loginBtn.textContent = 'Enter Book Inventory';
    }
    
    function showStatus(message, type) {
        statusDiv.textContent = message;
        statusDiv.className = `status-message status-${type}`;
        statusDiv.style.display = 'block';
        
        if (type === 'error') {
            setTimeout(() => {
                statusDiv.style.display = 'none';
            }, 5000);
        }
    }
    
    async function checkExistingSession() {
        try {
            const response = await fetch('/api/session');
            const data = await response.json();
            
            if (data.authenticated && data.user) {
                // User is already logged in, redirect to books
                showStatus(`Welcome back, ${data.user.username}! Redirecting...`, 'success');
                setTimeout(() => {
                    window.location.href = '/books';
                }, 1000);
            }
        } catch (error) {
            // Ignore errors, user is not logged in
            console.log('No existing session found');
        }
    }
    
    // Add some nice input effects
    const inputs = document.querySelectorAll('.form-input');
    inputs.forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.classList.add('focused');
        });
        
        input.addEventListener('blur', function() {
            this.parentElement.classList.remove('focused');
        });
    });
});



