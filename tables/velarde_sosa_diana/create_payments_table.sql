-- =============================================
-- Author: Velarde Sosa, Diana
-- Create date: November 2025
-- Description: Sample Data for Payments Table (35 entries)
-- Module: Payment Processing
-- Note: Requires Orders table to exist first
-- =============================================

USE urbanease_shop;

-- Insert 35 payment records with various statuses
INSERT INTO Payments (order_id, provider, provider_ref, amount, status, paid_at, created_at) VALUES
-- CAPTURED payments (successful)
(1, 'Stripe', 'ch_3N1L9J2eZvKYlo2C0123456789', 2513.90, 'CAPTURED', '2024-10-15 10:35:00', '2024-10-15 10:30:00'),
(2, 'PayPal', 'PAYID-MXYZ-1234-ABCD-5678', 1115.07, 'CAPTURED', '2024-10-18 14:25:00', '2024-10-18 14:20:00'),
(3, 'Stripe', 'ch_3N2K8I2eZvKYlo2C0234567890', 73.77, 'CAPTURED', '2024-10-20 09:20:00', '2024-10-20 09:15:00'),
(4, 'Square', 'sq_1234567890ABCDEFGH', 1020.91, 'CAPTURED', '2024-10-22 11:50:00', '2024-10-22 11:45:00'),
(5, 'Stripe', 'ch_3N3J7H2eZvKYlo2C0345678901', 390.98, 'CAPTURED', '2024-10-25 16:35:00', '2024-10-25 16:30:00'),
(6, 'PayPal', 'PAYID-NXYZ-2345-BCDE-6789', 116.22, 'CAPTURED', '2024-10-28 13:15:00', '2024-10-28 13:10:00'),
(7, 'Stripe', 'ch_3N4I6G2eZvKYlo2C0456789012', 86.94, 'CAPTURED', '2024-11-01 10:10:00', '2024-11-01 10:05:00'),
(8, 'Square', 'sq_2345678901BCDEFGHI', 105.08, 'CAPTURED', '2024-11-02 15:25:00', '2024-11-02 15:20:00'),
(9, 'Stripe', 'ch_3N5H5F2eZvKYlo2C0567890123', 71.76, 'CAPTURED', '2024-11-03 09:45:00', '2024-11-03 09:40:00'),
(10, 'PayPal', 'PAYID-OXYZ-3456-CDEF-7890', 2966.84, 'CAPTURED', '2024-09-15 11:25:00', '2024-09-15 11:20:00'),

-- More CAPTURED payments
(11, 'Stripe', 'ch_3N6G4E2eZvKYlo2C0678901234', 94.36, 'CAPTURED', '2024-09-20 14:40:00', '2024-09-20 14:35:00'),
(12, 'Square', 'sq_3456789012CDEFGHIJ', 221.18, 'CAPTURED', '2024-09-25 10:20:00', '2024-09-25 10:15:00'),
(13, 'Stripe', 'ch_3N7F3D2eZvKYlo2C0789012345', 96.38, 'CAPTURED', '2024-10-01 16:50:00', '2024-10-01 16:45:00'),
(14, 'PayPal', 'PAYID-PXYZ-4567-DEFG-8901', 97.19, 'CAPTURED', '2024-10-05 13:30:00', '2024-10-05 13:25:00'),
(15, 'Stripe', 'ch_3N8E2C2eZvKYlo2C0890123456', 153.38, 'CAPTURED', '2024-10-10 09:55:00', '2024-10-10 09:50:00'),
(21, 'Stripe', 'ch_3N9D1B2eZvKYlo2C0901234567', 83.57, 'CAPTURED', '2024-11-04 12:35:00', '2024-11-04 12:30:00'),
(22, 'Square', 'sq_4567890123DEFGHIJK', 280.76, 'CAPTURED', '2024-11-04 15:55:00', '2024-11-04 15:50:00'),
(23, 'Stripe', 'ch_3NAC0A2eZvKYlo2C1012345678', 66.38, 'CAPTURED', '2024-11-05 09:15:00', '2024-11-05 09:10:00'),
(24, 'PayPal', 'PAYID-QXYZ-5678-EFGH-9012', 37.38, 'CAPTURED', '2024-11-05 13:40:00', '2024-11-05 13:35:00'),
(25, 'Stripe', 'ch_3NBB9Z2eZvKYlo2C1123456789', 196.97, 'CAPTURED', '2024-11-05 16:25:00', '2024-11-05 16:20:00'),
(30, 'Square', 'sq_5678901234EFGHIJKL', 460.91, 'CAPTURED', '2024-11-06 09:20:00', '2024-11-06 09:15:00'),
(31, 'Stripe', 'ch_3NCA8Y2eZvKYlo2C1234567890', 754.92, 'CAPTURED', '2024-11-06 12:45:00', '2024-11-06 12:40:00'),
(32, 'PayPal', 'PAYID-RXYZ-6789-FGHI-0123', 201.98, 'CAPTURED', '2024-11-06 16:10:00', '2024-11-06 16:05:00'),
(33, 'Stripe', 'ch_3ND97X2eZvKYlo2C1345678901', 43.78, 'CAPTURED', '2024-11-07 10:25:00', '2024-11-07 10:20:00'),
(34, 'Square', 'sq_6789012345FGHIJKLM', 174.98, 'CAPTURED', '2024-11-07 13:55:00', '2024-11-07 13:50:00'),

-- AUTHORIZED payments (authorized but not captured yet)
(17, 'Stripe', 'ch_3NF75V2eZvKYlo2C1567890123', 140.57, 'AUTHORIZED', NULL, '2024-11-06 10:30:00'),
(18, 'PayPal', 'PAYID-SXYZ-7890-GHIJ-1234', 54.58, 'AUTHORIZED', NULL, '2024-11-06 14:15:00'),

-- INITIATED payments (payment started)
(19, 'Square', 'sq_7890123456GHIJKLMN', 83.66, 'INITIATED', NULL, '2024-11-07 08:20:00'),
(20, 'Stripe', 'ch_3NG64U2eZvKYlo2C1678901234', 173.98, 'INITIATED', NULL, '2024-11-07 11:45:00'),

-- FAILED payment
(26, 'Stripe', 'ch_3NH53T2eZvKYlo2C1789012345', 1020.91, 'FAILED', NULL, '2024-10-12 10:05:00'),

-- REFUNDED payments
(27, 'PayPal', 'PAYID-TXYZ-8901-HIJK-2345', 2698.92, 'REFUNDED', '2024-10-16 14:30:00', '2024-10-16 14:25:00'),
(28, 'Stripe', 'ch_3NI42S2eZvKYlo2C1890123456', 96.38, 'REFUNDED', '2024-09-10 11:35:00', '2024-09-10 11:30:00'),
(29, 'Square', 'sq_8901234567HIJKLMNO', 149.48, 'REFUNDED', '2024-09-28 15:50:00', '2024-09-28 15:45:00');

-- Verify inserted data
SELECT COUNT(*) AS total_payments FROM Payments;
SELECT 
    p.payment_id,
    p.order_id,
    p.provider,
    p.amount,
    p.status,
    p.paid_at,
    o.grand_total_amount
FROM Payments p
JOIN Orders o ON p.order_id = o.order_id
ORDER BY p.created_at DESC
LIMIT 10;
