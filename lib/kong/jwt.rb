module Kong
  class JWT
    include Base
    include BelongsToConsumer
    ATTRIBUTE_NAMES = %w(id key secret consumer_id).freeze
    API_END_POINT = '/jwt/'.freeze

    def create
      headers = { 'Content-Type' => 'application/json' }
      except_consumer_id_hash = attributes.reject { |k, v| k == 'consumer_id' }
      response = client.post(@api_end_point, except_consumer_id_hash, nil, headers)

      init_attributes(response)
      self
    end

    def delete
      except_consumer_id_hash = attributes.reject { |k, v| k == 'consumer_id' }
      except_id_hash = attributes.reject { |k, v| k == 'id' }
      # id = attributes["id"]
      response = client.delete("#{@api_end_point}/#{except_id_hash}", except_consumer_id_hash)

      init_attributes(response)
      self
    end
  end
end
