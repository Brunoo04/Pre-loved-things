DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS favorites;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS user_cart;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS chatrooms;
DROP TABLE IF EXISTS purchases;
DROP TABLE IF EXISTS purchaseData;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS tags_predefined;
DROP TABLE IF EXISTS tags_values;
DROP TABLE IF EXISTS conditions;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS shippingCode;
DROP TABLE IF EXISTS currency;
DROP TABLE IF EXISTS images;
DROP TABLE IF EXISTS item_images;

CREATE TABLE images (
    id VARCHAR PRIMARY KEY
);

CREATE TABLE item_images (
    image VARCHAR REFERENCES images,
    item VARCHAR REFERENCES items
);

CREATE TABLE categories (
    category VARCHAR PRIMARY KEY
);

CREATE TABLE tags (
    id VARCHAR PRIMARY KEY,
    category VARCHAR REFERENCES categories,
    tag VARCHAR
);

CREATE TABLE tags_predefined (
    tag VARCHAR references tags,
    value VARCHAR
);

CREATE TABLE tags_values (
    item VARCHAR references items,
    tag VARCHAR references tags,
    data VARCHAR
);

CREATE TABLE user_cart (
   user VARCHAR references users,
   item VARCHAR references items
);

CREATE TABLE purchaseData (
   buyer VARCHAR references users,
   deliveryDate INTEGER,
   state VARCHAR,
   address VARCHAR,
   city VARCHAR,
   postalCode VARCHAR,
   id VARCHAR PRIMARY KEY
);

CREATE TABLE purchases (
    item     VARCHAR references items,
    purchase VARCHAR references purchases
);

CREATE TABLE items (
    id VARCHAR PRIMARY KEY,
    name VARCHAR NOT NULL,
    price REAL NOT NULL,
    category VARCHAR references categories,
    date INTEGER,                             -- date the item was published
    description VARCHAR,
    mainImage VARCHAR REFERENCES images,
    creator VARCHAR REFERENCES users,
    sold INTEGER DEFAULT 0
);

CREATE TABLE users (
  user_id VARCHAR PRIMARY KEY,
  username VARCHAR UNIQUE,
  password VARCHAR,                  -- password stored in sha-1
  name VARCHAR,                       -- real name
  email VARCHAR UNIQUE,
  phone VARCHAR,
  currency VARCHAR references currency,
  image VARCHAR REFERENCES images DEFAULT 0,
  role VARCHAR(30) REFERENCES roles(name) DEFAULT 'user'
);

CREATE TABLE roles (
    name VARCHAR(30) PRIMARY KEY
);

CREATE TABLE comments (
  id VARCHAR PRIMARY KEY,            -- comment id
  mainuser VARCHAR REFERENCES users,   -- user this comment is about
  userc VARCHAR REFERENCES users, -- user that wrote the comment
  date INTEGER,                 -- date when news item was published in epoch format
  text VARCHAR,                       -- comment text
  rating INTEGER
);

CREATE TABLE favorites (
  user VARCHAR REFERENCES users,
  item VARCHAR REFERENCES items
);

CREATE TABLE messages (
    chatroom VARCHAR NOT NULL REFERENCES chatrooms,
    sender VARCHAR NOT NULL REFERENCES users,
    sentTime INTEGER NOT NULL,
    readTime INTEGER DEFAULT NULL,
    message VARCHAR NOT NULL
);

CREATE TABLE chatrooms (
   chatroom_id VARCHAR PRIMARY KEY,
   item_id VARCHAR NOT NULL REFERENCES items,
   seller_id VARCHAR NOT NULL REFERENCES users,
   buyer_id VARCHAR NOT NULL REFERENCES users
);

INSERT INTO roles VALUES ('user'), ('admin');

CREATE TABLE shippingCode (
    code VARCHAR
);

CREATE TABLE currency (
    code VARCHAR PRIMARY KEY,
    value REAL,
    symbol VARCHAR
);

INSERT INTO images VALUES
    ('0'), --profile.png
    ('1'); --flower.png

INSERT INTO item_images (item, image) VALUES
    ('1','1'),
    ('2','1'),
    ('3','1'),
    ('4','1'),
    ('5','1'),
    ('6','1'),
    ('7','1'),
    ('8','1'),
    ('9','1'),
    ('10','1'),
    ('11','1'),
    ('12','1'),
    ('13','1'),
    ('14','1'),
    ('15','1'),
    ('16','1'),
    ('17','1'),
    ('18','1'),
    ('19','1'),
    ('20','1');


INSERT INTO users (user_id, password, name, email, phone, username, currency)
VALUES
    ('1', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'John Doe', 'john@example.com', '1234567890', 'johny', 'USD'),
    ('2', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Jane Smith', 'jane@example.com', '9876543210', 'janey', 'EUR'),
    ('3', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Alice Wonder', 'alice@example.com', '5551234567', 'alicewonderful', 'GBP'),
    ('4', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Bob Green', 'bob@example.com', '4447890123', 'bobby', 'INR'),
    ('5', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Sarah Jones', 'sarah@example.com', '9998887777', 'sarita', 'AUD'),
    ('6', 'password321', 'Mike Andrews', 'mike@example.com', '1112223333', 'mikeymouse', 'CAD'),
    ('7', 'brownie', 'Emily Brown', 'emily@example.com', '7776665555', 'emiliii', 'SGD'),
    ('8', 'king123', 'Alex King', 'alex@example.com', '2223334444', 'kingofall', 'CHF'),
    ('9', 'sammy123', 'Sam Carter', 'sam@example.com', '6667778888', 'carteiro', 'MYR'),
    ('10', 'lisalisa', 'Lisa Adams', 'lisa@example.com', '3334445555', 'lisa', 'JPY'),
    ('74429f6c-6dc9-49bd-9c31-73df294f5bd6', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Carolina Montgomery', 'Carolina_Montgomery70@gmail.com', '910080502', 'Carol', 'EUR'),
    ('6179e03c-f7a7-4601-94e4-8b33266e4bb9', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Perry Rivers', 'Perry_Rivers50@gmail.com', '957101156', 'PERRYY', 'EUR'),
    ('dd22de70-a364-41a7-9ed4-d93894be3b53', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Ricky Joyce', 'Ricky_Joyce22@gmail.com', '969108048', 'Rolling4ever', 'EUR'),
    ('15b3547d-9a7c-4df6-b009-82ff5c7d2b8a', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Ron Coleman', 'Ron_Coleman33@gmail.com', '913639123', 'Ronei', 'EUR'),
    ('5d389996-7b06-4dbe-9402-2875b26bf403', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Malcolm Hoffman', 'Malcolm_Hoffman93@gmail.com', '957106414', 'MH', 'EUR'),
    ('e6fb2b5a-c0bb-4c04-a9c4-f9778977bc5e', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Robbie Coyle', 'Robbie_Coyle64@gmail.com', '999226752', 'Robbie64', 'EUR'),
    ('e8642d87-cd43-4d20-8e26-f9a43e28ff44', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Carrie Richards', 'Carrie_Richards87@gmail.com', '954933787', 'CC87', 'EUR'),
    ('bb0faa2a-743c-4144-99d4-27bfe949e5c1', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Chris Charles', 'Chris_Charles13@gmail.com', '960543243', 'Charlie', 'EUR'),
    ('c2dfc91f-6c7c-4ae4-b0d1-bcb0483206a8', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Sheila Preston', 'Sheila_Preston72@gmail.com', '955184411', 'Sheilaaa_', 'GBP'),
    ('82146581-ad4f-4b8b-b5fd-48c478087851', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Manuel Fields', 'Manuel_Fields80@gmail.com', '920802692', 'Fields8080', 'INR'),
    ('090ea498-7db9-4c2e-93a6-d68a5f479964', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Olga Olson', 'Olga_Olson6@gmail.com', '941618630', 'O_O', 'AUD'),
    ('b32b03b8-7210-436e-92fd-2fa183b4f658', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Zachary Andrews', 'Zachary_Andrews71@gmail.com', '960200069', 'zackk', 'CAD'),
    ('79c99578-db93-4156-9cce-000cb34829ff', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Casey Stevenson', 'Casey_Stevenson7@gmail.com', '971939623', 'not-the_father', 'SGD'),
    ('c89ce9e3-5abc-41fe-8414-a0cabf1eec95', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Ruth Elliot', 'Ruth_Elliot48@gmail.com', '981610736', 'Ell_48', 'CHF'),
    ('6f4fc1c9-bd29-479d-bff5-2ac502db1b50', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Andrea Greenwood', 'Andrea_Greenwood24@gmail.com', '975850978', 'andrea123', 'MYR'),
    ('aa5735cf-affc-43c1-8938-92c1b53f119a', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Randolph Matthews', 'Randolph_Matthews47@gmail.com', '998517823', '47_RM_47', 'JPY'),
    ('cb4f0761-590e-431c-a786-861ade932102', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Jesus Jones', 'Jesus_Jones39@gmail.com', '935740480', 'O_M_Me', 'CNY'),
    ('d6b25587-4310-4b69-8d04-09372d8a8ba4', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Kelvin Donovan', 'Kelvin_Donovan60@gmail.com', '933354073', 'Celsius', 'USD'),
    ('3a8a539d-8bdc-4e52-a86c-16a3af67dd17', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Lindsey McMillan', 'Lindsey_McMillan56@gmail.com', '930016152', 'Lindi', 'USD'),
    ('5c99c65e-4f32-4cf0-b736-83cdddca6d50', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Cora Katz', 'Cora_Katz88@gmail.com', '980937279', 'KitKat', 'USD'),
    ('dded65b5-f58e-45dd-87a3-b80d0c06f2e0', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Lorenzo Clarke', 'Lorenzo_Clarke5@gmail.com', '993076798', 'Lore5', 'USD'),
    ('44962523-7d16-4dfa-b9c4-a9c5d0fa6dc7', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Viola Carey', 'Viola_Carey27@gmail.com', '917059730', 'Guitarra_Carey', 'USD'),
    ('073811a5-7e63-4525-bde3-67635b11a818', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Latoya Gallegos', 'Latoya_Gallegos18@gmail.com', '942913064', 'Gal81', 'USD'),
    ('c1176c7b-4846-4bed-ba3e-ea9c4d625240', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Carlton Dougherty', 'Carlton_Dougherty81@gmail.com', '916045366', 'Dougherty2', 'USD'),
    ('0fcc89c1-5ed4-44d6-8973-41a0fdc76645', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Graciela Haney', 'Graciela_Haney73@gmail.com', '935067101', 'Haney_im_home', 'USD'),
    ('ab4db53b-9233-4684-b409-6920f25b44bd', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Tiffany Cameron', 'Tiffany_Cameron89@gmail.com', '980157605', 'Tiff89', 'USD'),
    ('f1be0523-8f5d-4411-84d6-8228efaccef9', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Wayne West', 'Wayne_West82@gmail.com', '949314032', 'Not_North82', 'USD'),
    ('3e12516b-fe08-4265-9a75-043d8789685d', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Leona Roth', 'Leona_Roth44@gmail.com', '990289177', 'Leona44', 'USD'),
    ('817b9c91-5587-44d7-8dc9-ee935bf78e16', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Vince Willson', 'Vince_Willson11@gmail.com', '915612952', 'Vience123', 'USD'),
    ('afcf970e-ba98-40bb-a66c-ce2bd0c0ef37', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Stephanie Watkins', 'Stephanie_Watkins28@gmail.com', '980681758', 'Steph_Wat_28', 'USD');
--
INSERT INTO users (user_id, password, name, email, phone, username, role, currency) VALUES
    ('11','2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Lisa Adams2', 'lisa2@example.com', '3334445555', 'lisa2', 'admin', 'EUR'),
    ('cc2931ab-3b55-4172-8db1-3914a6fb8c61', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Claude Moon', 'Claude_Moon99@gmail.com', '968032551', 'Santa_Sun', 'admin', 'USD'),
    ('cadaaa8d-59f8-4f96-88ab-9844ce1e842a', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Mabel Montgomery', 'Mabel_Montgomery52@gmail.com', '993690490', 'MnM52', 'admin', 'USD'),
    ('37787680-81d6-4518-b0b2-6028afe5fd37', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Zach Pratt', 'Zach_Pratt83@gmail.com', '927950085', 'Zack_P', 'admin', 'USD'),
    ('f97a426e-b368-4ebb-b5c8-61443d410d6d', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Esther Frey', 'Esther_Frey25@gmail.com', '930693697', 'EstherF', 'admin', 'USD'),
    ('98f86636-bfc5-4e11-9532-38fe154e2738', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Michelle Cornell', 'Michelle_Cornell92@gmail.com', '978776666', 'Mi_92', 'admin', 'USD'),
    ('2c6c9a25-f011-4230-b10a-a34d73ea5b8c', '2y10uiOS.8pUzfpRMyaGoLyE6uvcnSbxFnjm2qvUvqNM7EFc7c45SQj6W', 'Dee Riddle', 'Dee_Riddle71@gmail.com', '976503406', 'Riddle_me_this', 'admin', 'USD');

INSERT INTO items (id, name, price, date, description, creator, mainImage, category, sold)
VALUES
    ('1','Guitar', 299.99, '2024-04-10', 'Classic electric guitar.', '1','1', 'music', 1),
    ('2','Laptop', 899.99, '2024-04-10', 'High-performance laptop.', '2','1', 'technology', 1),
    ('3','Watch', 199.99, '2024-04-10', 'Luxury watch with timeless design.', '3','1', 'technology', 1),
    ('4','Bicycle', 399.00, '2024-04-10', 'Mountain bike for all terrains.', '4','1', 'sports', 1),
    ('5','Camera', 499.50, '2024-04-10', 'Great DSLR camera for beginners.', '5','1', '', 0),
    ('6','Smartphone', 599.99, '2024-04-10', 'Latest smartphone with advanced features.', '6','1', 'technology', 0),
    ('7','Television', 799.99, '2024-04-10', '4K HDR smart TV for immersive viewing.', '7','1', 'technology', 0),
    ('8','Desk', 149.50, '2024-04-10', 'Simple desk for home office.', '8','1', 'furniture', 0),
    ('9','Headphones', 99.99, '2024-04-10', 'Noise-cancelling wireless headphones.', '9','1', 'technology', 0),
    ('10','Backpack', 49.99, '2024-04-10', 'Durable backpack for everyday use.', '10','1', '', 0),
    ('797dc328-06ed-4ef4-a760-d2f7a726cbf6', 'Smartphone X Pro', 999.99, '2023-11-10', 'The Smartphone X Pro offers an unprecedented mobile experience with its 6.7-inch Super Retina display, A15 Bionic chip, and advanced camera system featuring night mode and 4K video recording. With up to 512GB storage, you can keep all your photos, videos, and apps at your fingertips. Face ID technology ensures secure access, while 5G connectivity keeps you connected at lightning speeds. The sleek design is both water and dust resistant, making it durable for everyday use. Includes wireless charging and a long-lasting battery life.', 'dded65b5-f58e-45dd-87a3-b80d0c06f2e0', '1', 'technology', 0),
    ('1118c349-ea50-4ada-b2ef-df6c4a434112', 'Gaming Laptop Z', 1499.99, '2023-12-15', 'Experience ultimate gaming performance with the Gaming Laptop Z, powered by the latest Intel i9 processor and NVIDIA RTX 3080 graphics card. Its 15.6-inch 4K display with a 144Hz refresh rate delivers stunning visuals and smooth gameplay. Equipped with 32GB RAM and 1TB SSD, this laptop ensures quick load times and ample storage for all your games. Advanced cooling technology keeps your system running at optimal temperatures, even during intense gaming sessions. The customizable RGB keyboard and immersive audio enhance your gaming experience.', '44962523-7d16-4dfa-b9c4-a9c5d0fa6dc7', '1', 'technology', 0),
    ('f641bb7e-3e23-412c-8b18-858274476f97', 'Wireless Noise-Canceling Headphones', 299.99, '2024-01-20', 'Immerse yourself in music with our Wireless Noise-Canceling Headphones. Featuring cutting-edge active noise cancellation, these headphones block out ambient noise, allowing you to focus on your audio. Enjoy high-fidelity sound with deep bass and crisp highs. The lightweight, over-ear design ensures comfort during extended listening sessions. With up to 30 hours of battery life on a single charge, you can listen to your favorite tracks all day. Bluetooth connectivity provides seamless pairing with your devices, and the built-in microphone allows for hands-free calls.', '073811a5-7e63-4525-bde3-67635b11a818', '1', 'technology', 0),
    ('937ad758-b16e-49b9-a1b8-923fc3287f39', '4K HDR Smart TV', 799.99, '2024-02-05', 'Upgrade your home entertainment with our 4K HDR Smart TV. This 55-inch television offers stunning picture quality with vibrant colors and deep blacks, thanks to HDR10 technology. Stream your favorite content from popular apps like Netflix, Hulu, and Amazon Prime with built-in Wi-Fi. The intuitive user interface makes navigating channels and apps a breeze. Multiple HDMI and USB ports allow for easy connectivity to external devices. Voice control compatibility with Alexa and Google Assistant provides a hands-free viewing experience. Sleek and stylish, it complements any living room decor.', 'c1176c7b-4846-4bed-ba3e-ea9c4d625240', '1', 'technology', 0),
    ('c67f9155-c8be-4823-8087-1611ea86f592', 'Fitness Tracker Watch', 199.99, '2024-03-18', 'Stay on top of your health goals with the Fitness Tracker Watch. This smartwatch tracks your daily activities, including steps, distance, calories burned, and heart rate. The sleep monitoring feature helps you understand your sleep patterns and improve your rest. With built-in GPS, you can accurately track your outdoor workouts. The bright, easy-to-read display shows notifications from your smartphone, keeping you connected on the go. Water-resistant up to 50 meters, it’s perfect for swimming and other water activities. Enjoy a battery life of up to 10 days on a single charge.', '0fcc89c1-5ed4-44d6-8973-41a0fdc76645', '1', 'sports', 0),
    ('81f89db9-85c5-46db-92f7-3e8102c9d95a', 'Ergonomic Office Chair', 299.99, '2024-04-10', 'Enhance your workspace with the Ergonomic Office Chair, designed for maximum comfort and support during long hours of sitting. The adjustable lumbar support and headrest provide personalized comfort, while the breathable mesh back keeps you cool. The chair features a tilt mechanism and height adjustment for optimal seating position. The high-density foam seat cushion ensures durability and comfort. With 360-degree swivel and smooth-rolling casters, you can move easily around your office. Its sleek, modern design fits seamlessly into any office environment.', 'dded65b5-f58e-45dd-87a3-b80d0c06f2e0', '1', 'home & kitchen', 0),
    ('5b5804df-ad58-445f-92ac-d73549e1f3cd', 'Espresso Machine', 499.99, '2024-05-05', 'Brew the perfect cup of coffee with our Espresso Machine. Featuring a 15-bar pressure pump, it delivers rich, flavorful espresso shots with a thick crema. The built-in steam wand allows you to froth milk for cappuccinos and lattes. The user-friendly control panel makes it easy to select your preferred coffee strength and volume. The machine has a large water reservoir and a removable drip tray for easy cleaning. Its compact design saves counter space, making it ideal for any kitchen. Enjoy café-quality coffee at home with this versatile espresso machine.', '44962523-7d16-4dfa-b9c4-a9c5d0fa6dc7', '1', 'home & kitchen', 0),
    ('5365dbb8-bc4b-444b-bcaf-ef5237c10ae1', 'Bluetooth Speaker', 129.99, '2024-06-01', 'Take your music anywhere with our portable Bluetooth Speaker. Featuring a compact design and powerful sound, this speaker delivers clear audio with deep bass. It’s equipped with a long-lasting battery, providing up to 24 hours of playback on a single charge. The rugged, water-resistant construction makes it perfect for outdoor use. Bluetooth 5.0 technology ensures stable, high-quality wireless connections with your devices. The built-in microphone allows for hands-free calls, and the integrated controls let you manage your music effortlessly.', 'ab4db53b-9233-4684-b409-6920f25b44bd', '1', 'technology', 0),
    ('82c66131-e29b-4638-959a-4ceb0f0178b9', 'Graphic Design Tablet', 349.99, '2024-06-15', 'Unleash your creativity with the Graphic Design Tablet. This tablet features a high-resolution 13.3-inch display with vibrant colors and precise touch sensitivity. The included stylus offers 8192 levels of pressure sensitivity, making it perfect for drawing, painting, and designing. Compatible with popular software like Adobe Photoshop and Illustrator, it enhances your digital art experience. The tablet connects to your computer via USB-C for fast and reliable data transfer. Its lightweight and portable design allow you to work from anywhere, making it an essential tool for artists and designers.', 'f1be0523-8f5d-4411-84d6-8228efaccef9', '1', 'technology', 0),
    ('2b433127-a3fa-4264-b85e-9d380e91ed57', 'Digital Camera', 1199.99, '2024-07-01', 'Capture stunning photos and videos with our Digital Camera. Equipped with a 24.2MP CMOS sensor and 4K video recording capabilities, it delivers high-quality images in any lighting condition. The fast autofocus system ensures sharp, clear shots, while the optical image stabilization reduces blur. With a variety of shooting modes and creative filters, you can experiment with your photography. The camera features a 3-inch tilting touchscreen for easy framing and review. Built-in Wi-Fi and Bluetooth allow for seamless sharing and remote control from your smartphone.', '3e12516b-fe08-4265-9a75-043d8789685d', '1', 'technology', 0),

('A6AEEACE-D1AA-BD67-E5A8-0B52FC54FCDF','primis','561.66','2025-02-27','ut mi. Duis risus odio, auctor vitae, aliquet nec, imperdiet nec, leo. Morbi neque tellus, imperdiet non, vestibulum nec, euismod in, dolor. Fusce feugiat. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aliquam auctor, velit eget laoreet posuere, enim nisl','74429f6c-6dc9-49bd-9c31-73df294f5bd6',1,'',0),
  ('8A4656C1-4161-5861-CD2B-A71254E64AC2','Duis','215.11','2024-11-26','in felis. Nulla tempor augue ac ipsum. Phasellus vitae mauris sit amet lorem semper auctor. Mauris vel turpis. Aliquam adipiscing lobortis risus. In mi pede, nonummy ut, molestie in, tempus eu, ligula. Aenean euismod mauris eu elit. Nulla facilisi. Sed','6179e03c-f7a7-4601-94e4-8b33266e4bb9',1,'clothes',0),
  ('DCB937F7-3ED4-7BEE-167C-5688A87C443B','ornare.','723.64','2025-01-07','blandit enim consequat purus. Maecenas libero est, congue a, aliquet vel, vulputate eu, odio. Phasellus at augue id ante dictum cursus. Nunc mauris elit, dictum eu, eleifend nec, malesuada ut, sem. Nulla interdum. Curabitur dictum. Phasellus in felis. Nulla tempor','dd22de70-a364-41a7-9ed4-d93894be3b53',1,'technology',0),
  ('496BE199-6F9B-53D3-6C0B-2A8DD40F1442','odio.','382.61','2023-11-28','Suspendisse eleifend. Cras sed leo. Cras vehicula aliquet libero. Integer in magna. Phasellus dolor elit, pellentesque a, facilisis non, bibendum sed, est. Nunc laoreet lectus quis massa. Mauris vestibulum, neque sed dictum eleifend, nunc risus varius orci, in consequat enim','15b3547d-9a7c-4df6-b009-82ff5c7d2b8a',1,'toys',0),
  ('6C347ABA-7A17-2F75-1766-DAE4BE62EAB1','quam,','734.94','2024-03-16','amet risus. Donec egestas. Aliquam nec enim. Nunc ut erat. Sed nunc est, mollis non, cursus non, egestas a, dui. Cras pellentesque. Sed dictum. Proin eget odio. Aliquam vulputate ullamcorper magna. Sed eu eros. Nam consequat dolor vitae dolor. Donec','5d389996-7b06-4dbe-9402-2875b26bf403',1,'cars',0),
  ('6AB8827B-59D7-8177-6DBB-7D8FDBE7C2A6','elit','463.81','2025-04-07','egestas. Fusce aliquet magna a neque. Nullam ut nisi a odio semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices iaculis odio. Nam interdum enim non nisi. Aenean eget metus. In nec orci. Donec nibh. Quisque nonummy ipsum non','e6fb2b5a-c0bb-4c04-a9c4-f9778977bc5e',1,'books',0),
  ('CD1C6B02-185D-BA39-45C3-89396029A2D1','pede,','714.86','2024-04-20','in faucibus orci luctus et ultrices posuere cubilia Curae Donec tincidunt. Donec vitae erat vel pede blandit congue. In scelerisque scelerisque dui. Suspendisse ac metus vitae velit egestas lacinia. Sed congue, elit sed consequat auctor, nunc nulla vulputate dui, nec','e8642d87-cd43-4d20-8e26-f9a43e28ff44',1,'furniture',0),
  ('83728629-AFAC-E91F-E494-C9C7C6178A06','venenatis','197.73','2024-08-11','augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci. Phasellus dapibus quam quis diam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce aliquet magna a neque. Nullam ut nisi a','bb0faa2a-743c-4144-99d4-27bfe949e5c1',1,'music',0),
  ('F842EA49-4EF6-A663-56C4-56B2485300EB','nec,','278.06','2023-06-09','Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Proin vel arcu eu odio tristique pharetra. Quisque ac libero nec ligula consectetuer rhoncus. Nullam velit dui, semper et, lacinia vitae, sodales at, velit. Pellentesque ultricies dignissim lacus.','c2dfc91f-6c7c-4ae4-b0d1-bcb0483206a8',1,'home & kitchen',0),
  ('D54A274E-4C83-E5C2-7982-12423D51860A','metus.','111.49','2023-08-09','sed pede nec ante blandit viverra. Donec tempus, lorem fringilla ornare placerat, orci lacus vestibulum lorem, sit amet ultricies sem magna nec quam. Curabitur vel lectus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec dignissim','82146581-ad4f-4b8b-b5fd-48c478087851',1,'sports',0),
    ('F9E2AFB6-450E-31AD-1AD7-542C7CB15335','auctor','277.76','2024-05-25','velit dui, semper et, lacinia vitae, sodales at, velit. Pellentesque ultricies dignissim lacus. Aliquam rutrum lorem ac risus. Morbi metus. Vivamus euismod urna. Nullam lobortis quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed diam lorem, auctor quis, tristique','090ea498-7db9-4c2e-93a6-d68a5f479964',1,'',0),
    ('E446434C-FB1A-1135-C7CD-38A0CCE501B6','sit','379.03','2023-07-17','dapibus gravida. Aliquam tincidunt, nunc ac mattis ornare, lectus ante dictum mi, ac mattis velit justo nec ante. Maecenas mi felis, adipiscing fringilla, porttitor vulputate, posuere vulputate, lacus. Cras interdum. Nunc sollicitudin commodo ipsum. Suspendisse non leo. Vivamus nibh dolor,','b32b03b8-7210-436e-92fd-2fa183b4f658',1,'',0),
    ('923CBADB-B7D7-63A4-418D-DC02E9FC8015','nostra,','251.66','2024-07-26','Cras vulputate velit eu sem. Pellentesque ut ipsum ac mi eleifend egestas. Sed pharetra, felis eget varius ultrices, mauris ipsum porta elit, a feugiat tellus lorem eu metus. In lorem. Donec elementum, lorem ut aliquam iaculis, lacus pede sagittis augue,','79c99578-db93-4156-9cce-000cb34829ff',1,'',0),
    ('CB7D3F42-29D4-A66C-BBA4-083C39949C9C','dignissim','595.81','2024-07-28','pellentesque, tellus sem mollis dui, in sodales elit erat vitae risus. Duis a mi fringilla mi lacinia mattis. Integer eu lacus. Quisque imperdiet, erat nonummy ultricies ornare, elit elit fermentum risus, at fringilla purus mauris a nunc. In at pede.','c89ce9e3-5abc-41fe-8414-a0cabf1eec95',1,'',0),
    ('388C3DD7-8E57-AFCC-0FEF-0462BA519EF5','libero','746.41','2023-09-05','Vivamus rhoncus. Donec est. Nunc ullamcorper, velit in aliquet lobortis, nisi nibh lacinia orci, consectetuer euismod est arcu ac orci. Ut semper pretium neque. Morbi quis urna. Nunc quis arcu vel quam dignissim pharetra. Nam ac nulla. In tincidunt congue','6f4fc1c9-bd29-479d-bff5-2ac502db1b50',1,'',0),
    ('D6AD4E01-9E52-BE3A-9F88-21E562B65F9D','Nunc','515.34','2024-09-26','cursus a, enim. Suspendisse aliquet, sem ut cursus luctus, ipsum leo elementum sem, vitae aliquam eros turpis non enim. Mauris quis turpis vitae purus gravida sagittis. Duis gravida. Praesent eu nulla at sem molestie sodales. Mauris blandit enim consequat purus.','aa5735cf-affc-43c1-8938-92c1b53f119a',1,'clothes',0),
    ('CEBD1DB9-AD9D-B62C-751E-1DE944CD1EC0','velit','563.22','2024-04-07','commodo auctor velit. Aliquam nisl. Nulla eu neque pellentesque massa lobortis ultrices. Vivamus rhoncus. Donec est. Nunc ullamcorper, velit in aliquet lobortis, nisi nibh lacinia orci, consectetuer euismod est arcu ac orci. Ut semper pretium neque. Morbi quis urna. Nunc','cb4f0761-590e-431c-a786-861ade932102',1,'technology',0),
    ('410A27EE-337B-8EA1-3D9F-727DF714A186','Nam','646.87','2025-05-19','Phasellus dapibus quam quis diam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce aliquet magna a neque. Nullam ut nisi a odio semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices iaculis odio.','d6b25587-4310-4b69-8d04-09372d8a8ba4',1,'toys',0),
    ('898BC632-9A2E-55FF-B2E2-696115A20380','ut','597.07','2024-04-01','consequat enim diam vel arcu. Curabitur ut odio vel est tempor bibendum. Donec felis orci, adipiscing non, luctus sit amet, faucibus ut, nulla. Cras eu tellus eu augue porttitor interdum. Sed auctor odio a purus. Duis elementum, dui quis accumsan','3a8a539d-8bdc-4e52-a86c-16a3af67dd17',1,'cars',0),
    ('7DD73648-86B4-0062-2119-3B6B01C096C2','dolor','770.56','2023-07-03','eleifend nec, malesuada ut, sem. Nulla interdum. Curabitur dictum. Phasellus in felis. Nulla tempor augue ac ipsum. Phasellus vitae mauris sit amet lorem semper auctor. Mauris vel turpis. Aliquam adipiscing lobortis risus. In mi pede, nonummy ut, molestie in, tempus','5c99c65e-4f32-4cf0-b736-83cdddca6d50',1,'books',0),
    ('520D64D6-DBE2-6EE2-6B30-1872EB34876B','pede,','469.99','2023-12-05','dictum placerat, augue. Sed molestie. Sed id risus quis diam luctus lobortis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Mauris ut quam vel sapien imperdiet ornare. In faucibus. Morbi vehicula. Pellentesque tincidunt tempus risus.','dded65b5-f58e-45dd-87a3-b80d0c06f2e0',1,'furniture',0),
    ('23BA17A1-7E26-B065-153A-D9D7A8C61AAE','ultricies','997.66','2025-01-15','velit. Aliquam nisl. Nulla eu neque pellentesque massa lobortis ultrices. Vivamus rhoncus. Donec est. Nunc ullamcorper, velit in aliquet lobortis, nisi nibh lacinia orci, consectetuer euismod est arcu ac orci. Ut semper pretium neque. Morbi quis urna. Nunc quis arcu','44962523-7d16-4dfa-b9c4-a9c5d0fa6dc7',1,'music',0),
    ('D7F264AE-9B56-44E8-A12F-7964021E9744','adipiscing','46.41','2024-09-24','Nullam feugiat placerat velit. Quisque varius. Nam porttitor scelerisque neque. Nullam nisl. Maecenas malesuada fringilla est. Mauris eu turpis. Nulla aliquet. Proin velit. Sed malesuada augue ut lacus. Nulla tincidunt, neque vitae semper egestas, urna justo faucibus lectus, a sollicitudin','073811a5-7e63-4525-bde3-67635b11a818',1,'home & kitchen',0),
    ('E9DEC9AD-FC02-21B4-F1B9-D82CA42BAE69','gravida','45.81','2023-08-29','nibh enim, gravida sit amet, dapibus id, blandit at, nisi. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Proin vel nisl. Quisque fringilla euismod enim. Etiam gravida molestie arcu. Sed eu nibh vulputate mauris sagittis placerat.','c1176c7b-4846-4bed-ba3e-ea9c4d625240',1,'sports',0),
    ('B037B16E-BB2D-56F1-E4AA-B637D74C496F','pellentesque','872.17','2023-11-12','aliquet vel, vulputate eu, odio. Phasellus at augue id ante dictum cursus. Nunc mauris elit, dictum eu, eleifend nec, malesuada ut, sem. Nulla interdum. Curabitur dictum. Phasellus in felis. Nulla tempor augue ac ipsum. Phasellus vitae mauris sit amet lorem','0fcc89c1-5ed4-44d6-8973-41a0fdc76645',1,'',0),
    ('BC4671B7-C35A-3C16-61DC-2143823ED6BA','enim.','638.12','2024-01-29','fringilla cursus purus. Nullam scelerisque neque sed sem egestas blandit. Nam nulla magna, malesuada vel, convallis in, cursus et, eros. Proin ultrices. Duis volutpat nunc sit amet metus. Aliquam erat volutpat. Nulla facilisis. Suspendisse commodo tincidunt nibh. Phasellus nulla. Integer','ab4db53b-9233-4684-b409-6920f25b44bd',1,'',0),
    ('2545E484-6DB9-DF2C-6B2B-F184ACEBD083','tempor','754.18','2024-09-25','sed pede. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Proin vel arcu eu odio tristique pharetra. Quisque ac libero nec ligula consectetuer rhoncus. Nullam velit dui, semper et, lacinia vitae, sodales at, velit. Pellentesque ultricies','f1be0523-8f5d-4411-84d6-8228efaccef9',1,'clothes',0),
    ('5DFC2448-4A50-9AF3-A9D1-DD35C5130B34','feugiat','615.33','2023-09-19','nonummy ultricies ornare, elit elit fermentum risus, at fringilla purus mauris a nunc. In at pede. Cras vulputate velit eu sem. Pellentesque ut ipsum ac mi eleifend egestas. Sed pharetra, felis eget varius ultrices, mauris ipsum porta elit, a feugiat','3e12516b-fe08-4265-9a75-043d8789685d',1,'technology',0),
    ('7C793366-D15C-168D-A4A7-75D791846F17','in,','90.62','2023-06-26','mattis. Cras eget nisi dictum augue malesuada malesuada. Integer id magna et ipsum cursus vestibulum. Mauris magna. Duis dignissim tempor arcu. Vestibulum ut eros non enim commodo hendrerit. Donec porttitor tellus non magna. Nam ligula elit, pretium et, rutrum non,','817b9c91-5587-44d7-8dc9-ee935bf78e16',1,'toys',0),
    ('E211AB9E-6B57-5162-C47B-9B1CDB527180','et','830.97','2023-09-25','semper, dui lectus rutrum urna, nec luctus felis purus ac tellus. Suspendisse sed dolor. Fusce mi lorem, vehicula et, rutrum eu, ultrices sit amet, risus. Donec nibh enim, gravida sit amet, dapibus id, blandit at, nisi. Cum sociis natoque penatibus','afcf970e-ba98-40bb-a66c-ce2bd0c0ef37',1,'cars',0),
    ('61BCDB7C-E3F7-D52A-5DB6-24A4C5964427','tincidunt','77.42','2025-04-10','luctus vulputate, nisi sem semper erat, in consectetuer ipsum nunc id enim. Curabitur massa. Vestibulum accumsan neque et nunc. Quisque ornare tortor at risus. Nunc ac sem ut dolor dapibus gravida. Aliquam tincidunt, nunc ac mattis ornare, lectus ante dictum','74429f6c-6dc9-49bd-9c31-73df294f5bd6',1,'books',0),
    ('83EB3D99-BA35-C17D-1A99-2A9E7DCAC448','neque','185.39','2023-05-25','imperdiet dictum magna. Ut tincidunt orci quis lectus. Nullam suscipit, est ac facilisis facilisis, magna tellus faucibus leo, in lobortis tellus justo sit amet nulla. Donec non justo. Proin non massa non ante bibendum ullamcorper. Duis cursus, diam at pretium','6179e03c-f7a7-4601-94e4-8b33266e4bb9',1,'furniture',0),
    ('3636A8AA-C362-7504-B79C-1996EEC54642','accumsan','611.14','2023-08-22','elit fermentum risus, at fringilla purus mauris a nunc. In at pede. Cras vulputate velit eu sem. Pellentesque ut ipsum ac mi eleifend egestas. Sed pharetra, felis eget varius ultrices, mauris ipsum porta elit, a feugiat tellus lorem eu metus.','dd22de70-a364-41a7-9ed4-d93894be3b53',1,'music',0),
    ('46218D2C-D42D-9244-834A-4F212DE1369C','lacinia','759.02','2024-02-14','quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed diam lorem, auctor quis, tristique ac, eleifend vitae, erat. Vivamus nisi. Mauris nulla. Integer urna. Vivamus molestie dapibus ligula. Aliquam erat volutpat. Nulla dignissim. Maecenas ornare egestas ligula. Nullam feugiat','15b3547d-9a7c-4df6-b009-82ff5c7d2b8a',1,'home & kitchen',0),
    ('18CB98F6-4E63-CFB7-F163-5ABE7408BB72','malesuada','162.70','2025-02-11','dictum augue malesuada malesuada. Integer id magna et ipsum cursus vestibulum. Mauris magna. Duis dignissim tempor arcu. Vestibulum ut eros non enim commodo hendrerit. Donec porttitor tellus non magna. Nam ligula elit, pretium et, rutrum non, hendrerit id, ante. Nunc','5d389996-7b06-4dbe-9402-2875b26bf403',1,'sports',0),
    ('96464ABB-D8EC-65E6-64D5-0B4AAEC727DE','quam.','609.99','2024-03-11','fringilla purus mauris a nunc. In at pede. Cras vulputate velit eu sem. Pellentesque ut ipsum ac mi eleifend egestas. Sed pharetra, felis eget varius ultrices, mauris ipsum porta elit, a feugiat tellus lorem eu metus. In lorem. Donec elementum,','e6fb2b5a-c0bb-4c04-a9c4-f9778977bc5e',1,'',0),
    ('8AD617EE-4F17-E5C3-23A5-D4A37D5F9404','Vestibulum','402.81','2023-11-14','faucibus ut, nulla. Cras eu tellus eu augue porttitor interdum. Sed auctor odio a purus. Duis elementum, dui quis accumsan convallis, ante lectus convallis est, vitae sodales nisi magna sed dui. Fusce aliquam, enim nec tempus scelerisque, lorem ipsum sodales','e8642d87-cd43-4d20-8e26-f9a43e28ff44',1,'clothes',0),
    ('A44BA7A3-831B-8798-1292-1BC32B2604CD','mollis','263.57','2025-01-18','sit amet diam eu dolor egestas rhoncus. Proin nisl sem, consequat nec, mollis vitae, posuere at, velit. Cras lorem lorem, luctus ut, pellentesque eget, dictum placerat, augue. Sed molestie. Sed id risus quis diam luctus lobortis. Class aptent taciti sociosqu','bb0faa2a-743c-4144-99d4-27bfe949e5c1',1,'technology',0),
    ('C4739D79-37FF-3391-BEB6-0718AADB2C85','diam.','17.77','2024-11-21','malesuada fames ac turpis egestas. Fusce aliquet magna a neque. Nullam ut nisi a odio semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices iaculis odio. Nam interdum enim non nisi. Aenean eget metus. In nec orci. Donec nibh.','c2dfc91f-6c7c-4ae4-b0d1-bcb0483206a8',1,'toys',0),
    ('95DB6667-2212-7160-DAE7-EB1CA5D21DD2','mi.','493.62','2024-08-16','nec, eleifend non, dapibus rutrum, justo. Praesent luctus. Curabitur egestas nunc sed libero. Proin sed turpis nec mauris blandit mattis. Cras eget nisi dictum augue malesuada malesuada. Integer id magna et ipsum cursus vestibulum. Mauris magna. Duis dignissim tempor arcu.','82146581-ad4f-4b8b-b5fd-48c478087851',1,'cars',0),
    ('8229C1E2-C342-A4E4-C638-A9A072AB7590','felis,','651.82','2025-03-16','convallis ligula. Donec luctus aliquet odio. Etiam ligula tortor, dictum eu, placerat eget, venenatis a, magna. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Etiam laoreet, libero et tristique pellentesque, tellus sem mollis dui, in sodales elit erat vitae risus.','090ea498-7db9-4c2e-93a6-d68a5f479964',1,'books',0),
    ('D088873E-5172-171E-C952-EB9BEFD31AF2','ut','894.73','2025-05-07','Nulla facilisis. Suspendisse commodo tincidunt nibh. Phasellus nulla. Integer vulputate, risus a ultricies adipiscing, enim mi tempor lorem, eget mollis lectus pede et risus. Quisque libero lacus, varius et, euismod et, commodo at, libero. Morbi accumsan laoreet ipsum. Curabitur consequat,','b32b03b8-7210-436e-92fd-2fa183b4f658',1,'furniture',0),
    ('EC65821C-DD55-4219-C2F3-12BDE8C506C7','a,','675.69','2023-07-12','sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna.','79c99578-db93-4156-9cce-000cb34829ff',1,'music',0),
    ('1E3B6795-5827-1FB3-6AA6-916700E4C4DC','et','725.12','2024-07-27','sed turpis nec mauris blandit mattis. Cras eget nisi dictum augue malesuada malesuada. Integer id magna et ipsum cursus vestibulum. Mauris magna. Duis dignissim tempor arcu. Vestibulum ut eros non enim commodo hendrerit. Donec porttitor tellus non magna. Nam ligula','c89ce9e3-5abc-41fe-8414-a0cabf1eec95',1,'home & kitchen',0),
    ('6BE79653-CDB0-C5E9-455F-87BCEA76548E','turpis.','387.20','2023-10-25','ultrices. Vivamus rhoncus. Donec est. Nunc ullamcorper, velit in aliquet lobortis, nisi nibh lacinia orci, consectetuer euismod est arcu ac orci. Ut semper pretium neque. Morbi quis urna. Nunc quis arcu vel quam dignissim pharetra. Nam ac nulla. In tincidunt','6f4fc1c9-bd29-479d-bff5-2ac502db1b50',1,'sports',0),
    ('637E0DAA-9009-B934-C158-16D8443E9669','metus.','18.15','2024-01-29','elit erat vitae risus. Duis a mi fringilla mi lacinia mattis. Integer eu lacus. Quisque imperdiet, erat nonummy ultricies ornare, elit elit fermentum risus, at fringilla purus mauris a nunc. In at pede. Cras vulputate velit eu sem. Pellentesque ut','aa5735cf-affc-43c1-8938-92c1b53f119a',1,'',0),
    ('7624F411-8C3C-A243-5E6B-AD7B02583B88','luctus','324.59','2023-10-26','molestie pharetra nibh. Aliquam ornare, libero at auctor ullamcorper, nisl arcu iaculis enim, sit amet ornare lectus justo eu arcu. Morbi sit amet massa. Quisque porttitor eros nec tellus. Nunc lectus pede, ultrices a, auctor non, feugiat nec, diam. Duis','cb4f0761-590e-431c-a786-861ade932102',1,'clothes',0),
    ('A99A8C3A-8352-943D-3934-79BDE5127BE2','nulla','80.50','2023-09-10','mauris. Integer sem elit, pharetra ut, pharetra sed, hendrerit a, arcu. Sed et libero. Proin mi. Aliquam gravida mauris ut mi. Duis risus odio, auctor vitae, aliquet nec, imperdiet nec, leo. Morbi neque tellus, imperdiet non, vestibulum nec, euismod in,','d6b25587-4310-4b69-8d04-09372d8a8ba4',1,'technology',0),
    ('30416488-6A54-61B1-DAEF-A02D6355BBE4','Morbi','117.68','2023-11-24','turpis nec mauris blandit mattis. Cras eget nisi dictum augue malesuada malesuada. Integer id magna et ipsum cursus vestibulum. Mauris magna. Duis dignissim tempor arcu. Vestibulum ut eros non enim commodo hendrerit. Donec porttitor tellus non magna. Nam ligula elit,','3a8a539d-8bdc-4e52-a86c-16a3af67dd17',1,'toys',0),
    ('1CA3F934-6B48-F39A-EE43-008435D63CFC','sagittis','217.62','2024-04-09','sapien. Cras dolor dolor, tempus non, lacinia at, iaculis quis, pede. Praesent eu dui. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eget magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum fermentum metus. Aenean sed','5c99c65e-4f32-4cf0-b736-83cdddca6d50',1,'cars',0);




INSERT INTO comments (id, mainuser, userc, date, text, rating)
VALUES
    ('1', '1', '2', '2024-04-10', 'Great guitar!', 5),
    ('2', '2', '1', '2024-04-10', 'Excellent laptop.', 4),
    ('3', '3', '2', '2024-04-10', 'Nice camera!', 4),
    ('4', '4', '3', '2024-04-10', 'Awesome watch.', 5),
    ('5', '1', '2', '2024-04-10', 'Love this bike!', 5),
    ('6', '1', '3', '2024-04-10', 'Fantastic phone.', 4);

INSERT INTO favorites (user, item)
VALUES
    ('john_doe', '1'),
    ('jane_smith', '2'),
    ('alice_wonder', '2'),
    ('alice_wonder', '5'),
    ('bob_green', '3'),
    ('sarah_jones', '4'),
    ('mike_andrews', '6'),
    ('emily_brown', '7'),
    ('alex_king', '8'),
    ('sam_carter', '9'),
    ('lisa_adams', '10');


INSERT INTO user_cart (user, item)
VALUES
    ('1', 'Guitar'),
    ('2', 'Laptop'),
    ('3', 'Camera'),
    ('4', 'Watch'),
    ('5', 'Bicycle'),
    ('6', 'Smartphone'),
    ('7', 'Television'),
    ('8', 'Desk'),
    ('9', 'Headphones'),
    ('10', 'Backpack');

INSERT INTO chatrooms (chatroom_id, item_id, seller_id, buyer_id)
VALUES
    ('1','1', '1', '2'),
    ('2','2', '3', '4'),
    ('3','3', '1', '4');

INSERT INTO messages (chatroom, sender, sentTime, readTime, message)
VALUES
    ('1', '1', 1648732345, NULL, 'Hi there! Is item 10 still available?'),
    ('1', '1', 1648732345, NULL, 'Hi there! Is item 10 still available?'),
    ('1', '2', 1648741234, 1648750000, 'Yes, item 10 is available. Are you interested in purchasing it?'),
    ('1', '1', 1648763123, NULL, 'Great! When can we meet for the transaction?'),
    ('1', '2', 1648780098, NULL, 'I am available on weekends. How about Saturday afternoon?'),
    ('1', '1', 1648791234, NULL, 'Saturday afternoon works for me. Let''s confirm the details.'),
    ('1', '2', 1648802345, NULL, 'Perfect! Let''s meet at the coffee shop near the park.'),
    ('1', '1', 1648813456, NULL, 'See you there!'),
    ('1', '2', 1648824567, NULL, 'Looking forward to it!'),
    ('1', '1', 1648835678, NULL, 'I''ll be wearing a blue jacket.'),
    ('1', '2', 1648846789, NULL, 'Got it! I''ll be in a red hat.'),
    ('1', '1', 1648857890, NULL, 'Did you arrive?'),
    ('1', '2', 1648868901, NULL, 'I''m here. Where are you?'),
    ('1', '1', 1648880012, NULL, 'I''m near the entrance.'),
    ('1', '2', 1648891123, NULL, 'I see you!'),
    ('1', '1', 1648902234, NULL, 'Let''s finalize the transaction.'),
    ('1', '2', 1648913345, NULL, 'Sure, here''s the payment.'),
    ('2', '3', 1648732345, NULL, 'Hello! I''m interested in item 11.'),
    ('2', '4', 1648741234, 1648750000, 'Great! It''s still available.'),
    ('2', '3', 1648763123, NULL, 'Can we arrange a meetup?'),
    ('2', '4', 1648780098, NULL, 'Sure, when are you available?'),
    ('2', '3', 1648791234, NULL, 'I''m free on weekdays after 5 PM.'),
    ('2', '4', 1648802345, NULL, 'How about Thursday evening?'),
    ('2', '3', 1648813456, NULL, 'Thursday evening works for me.'),
    ('2', '4', 1648824567, NULL, 'Let''s meet at the shopping mall.'),
    ('2', '3', 1648835678, NULL, 'Sounds good. See you there!'),
    ('2', '4', 1648846789, NULL, 'See you on Thursday!'),
    ('2', '3', 1648857890, NULL, 'I''m wearing a black hat.'),
    ('2', '4', 1648868901, NULL, 'Got it! I''ll be in a green shirt.'),
    ('2', '3', 1648880012, NULL, 'Let''s finalize the details on Thursday.'),
    ('2', '4', 1648891123, NULL, 'Sure, looking forward to it!'),
    ('2', '3', 1648902234, NULL, 'See you soon.'),
    ('2', '4', 1648913345, NULL, 'Take care!'),
    ('3', '1', 1648902234, NULL, 'See you soon.');


INSERT INTO purchaseData (id, buyer, deliveryDate, state, address, city, postalCode) VALUES
    ('1','1', '2020-10-14', 'shipping', 'Rua very', 'Valbom', '4420-150'),
    ('2','1','2024-10-10', 'preparing', 'Rua pocuo', 'Caniço', '4480-220'),
    ('3','4', '2024-10-10', 'preparing', 'Rua muiro', 'Lisbon', '4500-209'),
    ('4','2', '2024-10-10', 'delivered', 'Ruaaa', 'Porto', '6492-943');

INSERT INTO purchases (item, purchase) VALUES
                                           ('2', '1'),
                                           ('3', '1'),
                                           ('4', '2'),
                                           ('1', '3');

INSERT INTO categories (category) VALUES
                                      (''),
                                      ('clothes'),
                                      ('technology'),
                                      ('toys'),
                                      ('cars'),
                                      ('books'),
                                      ('furniture'),
                                      ('music'),
                                      ('home & kitchen'),
                                      ('sports');
INSERT INTO tags (id, category, tag) VALUES
                                     ('1','', 'condition'),
                                     ('2','', 'tag'),
                                     ('3','clothes', 'size'),
                                     ('4','clothes', 'brand'),
                                     ('5','cars', 'model'),
                                     ('6','toys', 'brand'),
                                     ('7','books', 'author');


INSERT INTO tags_predefined (tag, value) VALUES
                                    ('1', 'new'),
                                    ('1', 'old'),
                                    ('1', 'used'),
                                    ('3', 'S'),
                                    ('3', 'M'),
                                    ('3', 'L');

INSERT INTO tags_values (item, tag, data) VALUES
                                     ('2', '5', 'Cassandra Clare'),
                                     ('3', '3', 'S'),
                                     ('4', '3', 'S'),
                                     ('5', '3', 'M'),
                                     ('4', '2', 'bela'),
                                     ('1', '1', 'new'),
                                     ('2', '1', 'old'),
                                     ('3', '1', 'new'),
                                     ('4', '1', 'used'),
                                     ('5', '1', 'new'),
                                     ('6', '1', 'old'),
                                     ('3', '2', 'bel');

INSERT INTO shippingCode (code) VALUES ('abc'), ('hey');

INSERT INTO currency (code, value, symbol) VALUES
                                               ('EUR', 1.000000, '€'),
                                               ('USD', 1.070080, '$'),
                                               ('GBP', 0.854439, '£'),
                                               ('INR', 89.310771, '₹'),
                                               ('AUD', 1.633299, '$'),
                                               ('CAD', 1.462732, '$'),
                                               ('SGD', 1.456636, '$'),   
                                               ('CHF', 0.977023, 'Fr'),
                                               ('MYR', 5.102757, 'RM'),
                                               ('JPY', 167.684120, '¥'),
                                               ('CNY', 7.750000, '¥');