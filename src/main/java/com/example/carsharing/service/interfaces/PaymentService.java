package com.example.carsharing.service.interfaces;

import com.example.carsharing.dto.PaymentAfterCreationDto;
import com.example.carsharing.dto.PaymentCreateDto;
import com.example.carsharing.entity.Payment;

import java.util.UUID;

public interface PaymentService {
    Payment getPaymentById(UUID id);
    String deletePaymentById(UUID id);
    PaymentAfterCreationDto createPayment(PaymentCreateDto paymentCreateDto);
    Payment updatePaymentById(UUID id, PaymentCreateDto paymentCreateDto);
}
