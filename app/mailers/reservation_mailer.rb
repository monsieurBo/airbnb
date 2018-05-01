class ReservationMailer < ApplicationMailer
	def booking_email(customer, host, reservation_id)
		@customer = customer
		@host = host
		@reservation_id = reservation_id
		@url  = "http://127.0.0.1:3000/reservations/#{@reservation_id}"
		mail(to: @customer.email, subject: 'Booking Confirmation')
	end
end
