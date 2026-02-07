// Main JavaScript file for Cargo Management System

// Form validation
function validateForm(formId) {
    const form = document.getElementById(formId);
    if (form) {
        form.addEventListener('submit', function(e) {
            const requiredFields = form.querySelectorAll('[required]');
            let isValid = true;
            
            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    isValid = false;
                    field.style.borderColor = '#dc3545';
                } else {
                    field.style.borderColor = '#e0e0e0';
                }
            });
            
            if (!isValid) {
                e.preventDefault();
                alert('Please fill in all required fields');
            }
        });
    }
}

// Initialize form validations
document.addEventListener('DOMContentLoaded', function() {
    // Add any initialization code here
    console.log('Cargo Management System loaded');
});

// Auto-hide error messages after 5 seconds
document.addEventListener('DOMContentLoaded', function() {
    const errorMessages = document.querySelectorAll('.error-message');
    errorMessages.forEach(msg => {
        setTimeout(() => {
            msg.style.opacity = '0';
            setTimeout(() => msg.remove(), 300);
        }, 5000);
    });
});

// Print functionality for invoices
function printInvoice() {
    window.print();
}

// Confirm delete actions
function confirmDelete(message) {
    return confirm(message || 'Are you sure you want to delete this item?');
}
