from scripts.taxi import get_taxi_for_user
from scripts.extras import read,write
from scripts.ai import predict, train_model

if __name__ == "__main__":
    data = read()
    
    if data['function'] == 'find_taxi':
        output = get_taxi_for_user(data)
    elif data['function'] == "predict":
        output = predict(data)
    elif data['function'] == 'train':
        output = train_model()

    write(output)
