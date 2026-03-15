// Form handling and validation
import { showToast } from './ui.js';

export function initForm() {
    const contactForm = document.getElementById('contact-form');
    if (!contactForm) return;

    // Real-time validation
    const inputs = contactForm.querySelectorAll('input, textarea, select');
    const getErrorElement = (input) => input.parentElement.querySelector('.error-message');
    
    inputs.forEach(input => {
        const errorElement = getErrorElement(input);
        const validate = () => validateInput(input, errorElement);
        
        input.addEventListener('input', validate);
        input.addEventListener('blur', validate);
    });

    contactForm.addEventListener('submit', async (e) => {
        e.preventDefault();

        // Validate all fields before submission
        let isFormValid = true;
        inputs.forEach(input => {
            if (!validateInput(input, getErrorElement(input))) {
                isFormValid = false;
            }
        });

        if (!isFormValid) {
            showToast('Please correct the errors in the form.', true);
            return;
        }

        const submitBtn = contactForm.querySelector('button[type="submit"]');
        // specifically target the text span, not the glitch spans or icons
        const submitBtnText = submitBtn.querySelector('span:not(.glitch-layer):not(.glitch) > span:first-child');
        
        let originalText = "Send Message";
        if (submitBtnText) {
            originalText = submitBtnText.innerText;
        }

        try {
            submitBtn.disabled = true;
            if (submitBtnText) submitBtnText.innerText = 'SENDING...';

            const formData = {
                first_name: contactForm.querySelector('#first_name').value,
                last_name: contactForm.querySelector('#last_name').value,
                email: contactForm.querySelector('#email').value,
                course: contactForm.querySelector('#course').value,
                message: contactForm.querySelector('#message').value
            };

            const response = await fetch('/api/contact', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            });

            const result = await response.json();

            if (result.status === 'success') {
                showToast(result.message);
                contactForm.reset();
                // Clear validation styles
                inputs.forEach(input => {
                    input.classList.remove('border-green-500', 'border-red-500');
                    const errorElement = input.parentElement.querySelector('.error-message');
                    if (errorElement) errorElement.style.display = 'none';
                });
            } else {
                showToast('Error: ' + (result.message || 'Something went wrong'), true);
            }
        } catch (error) {
            console.error('Contact form error:', error);
            showToast('Failed to connect to the server.', true);
        } finally {
            submitBtn.disabled = false;
            if (submitBtnText) submitBtnText.innerText = originalText;
        }
    });
}

function validateInput(input, errorElement) {
    let isValid = true;

    if (input.required && !input.value.trim()) {
        isValid = false;
    } else if (input.type === 'email' && input.value.trim()) {
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(input.value)) {
            isValid = false;
        }
    }

    if (!isValid) {
        input.classList.add('input-error');
        if (errorElement) errorElement.style.display = 'block';
    } else {
        input.classList.remove('input-error');
        if (errorElement) errorElement.style.display = 'none';
    }

    return isValid;
}
