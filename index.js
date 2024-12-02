const express = require("express");
const app = express();
const userRoutes = require('./routes/userRoutes');
const productRoutes = require('./routes/productRoutes');
const orderRoutes = require('./routes/orderRoutes');
const saleRoutes=require('./routes/saleRoutes');
const cors = require("cors");
const path = require('path'); 

app.use(cors({
    origin: 'https://vercel-front-jeissonrojas20s-projects.vercel.app',
    credentials: true
}));
app.use(express.json());

app.use('/uploads', express.static(path.join(__dirname, 'public/uploads')));
app.use('/users', userRoutes);
app.use('/products', productRoutes);
app.use('/orders', orderRoutes);
app.use('/sale', saleRoutes);

app.listen(3002,()=>{
    console.log("Corriendo en el puerto 3002");
    
})
