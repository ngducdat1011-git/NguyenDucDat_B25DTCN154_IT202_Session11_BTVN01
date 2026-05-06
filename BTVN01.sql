DELIMITER //

CREATE PROCEDURE CancelAppointment(IN p_appointment_id INT)
BEGIN
    DECLARE current_status VARCHAR(20);

    SELECT status INTO current_status
    FROM Appointments
    WHERE appointment_id = p_appointment_id;

    IF current_status IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Appointment does not exist';

    ELSEIF current_status <> 'Pending' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Only Pending appointments can be cancelled';

    ELSE
        UPDATE Appointments
        SET status = 'Cancelled'
        WHERE appointment_id = p_appointment_id;
    END IF;

END //

DELIMITER ;
CALL CancelAppointment(104);