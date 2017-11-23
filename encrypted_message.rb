class EncryptedMessage
  ALPHA = (:a..:z).to_a + ["?", ":", ".", "'"]
  OMEGA = ENV["OMEGA"].split(",").map(&:to_sym)

  def encrypt(message)
    message = message.split("").map(&:downcase)
    key     = generate_key
    alpha   = ALPHA.rotate(ALPHA.index(key[0]))
    omega   = OMEGA.rotate(OMEGA.index(key[1]))
    process_cipher(message, alpha, omega)

    encrypted_msg = process_cipher(message, alpha, omega)

    { message: encrypted_msg,
      key:     "#{alpha[0]}:#{omega[0]}" }
  end


  def decrypt(message, key)
    message = message.split("").map(&:downcase).map(&:to_sym)
    key     = key.split(":")
    alpha   = ALPHA.rotate(ALPHA.index(key[0].to_sym))
    omega   = OMEGA.rotate(OMEGA.index(key[1].to_sym))

    decrypted_msg = process_cipher(message, omega, alpha)

    { message: decrypted_msg }
  end

  private

  def process_cipher(message, source, dest)
    msg =  String.new
    message.each do |letter|
      letter_position = source.index(letter.to_sym)
      if letter_position.nil?
        msg << " "
      else
        msg << dest[letter_position].to_s
      end
    end

    msg
  end

  def generate_key
   [ALPHA[rand(0..25)], OMEGA[rand(0..25)]]
  end
end
