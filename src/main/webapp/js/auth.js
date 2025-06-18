document.addEventListener('DOMContentLoaded', () => {
    const reviewForm = document.querySelector('.review-form');
    if (reviewForm) {
        reviewForm.addEventListener('submit', (e) => {
            const rating = parseInt(document.querySelector('input[name="rating"]').value);
            const comment = document.querySelector('textarea[name="comment"]').value.trim();

            if (isNaN(rating) || rating < 1 || rating > 5) {
                e.preventDefault();
                alert('Please enter a valid rating between 1 and 5.');
            }

            if (comment.length > 500) {
                e.preventDefault();
                alert('Comment cannot exceed 500 characters.');
            }
        });
    }
});