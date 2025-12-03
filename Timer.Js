function calculateDays() {
    const startDateInput = document.getElementById('startDate').value;
    const endDateInput = document.getElementById('endDate').value;
    const resultElement = document.getElementById('result');

    if (!startDateInput || !endDateInput) {
        resultElement.innerText = "Please select both start and end dates.";
        return;
    }

    const startDate = new Date(startDateInput);
    const endDate = new Date(endDateInput);

    // Calculate the difference in milliseconds
    const timeDifference = endDate.getTime() - startDate.getTime();

    // Convert milliseconds to days
    const daysDifference = Math.floor(timeDifference / (1000 * 60 * 60 * 24));

    resultElement.innerText = `Number of days between the dates: ${daysDifference}`;
}