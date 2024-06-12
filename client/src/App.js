import { createBrowserRouter, Outlet, RouterProvider } from "react-router-dom";
import Register from "./pages/Register";
import Login from "./pages/Login";
import Write from "./pages/Write";
import Home from "./pages/Home";
import Single from "./pages/Single";
import TrajeTipico from "./pages/TrajeTipico";
import TTipico from "./pages/TTipico";
import TrajeGala from "./pages/TrajeGala";
import TGala from "./pages/TGala";
import Preguntas from "./pages/Preguntas";
import Carrusel from "./pages/Carrusel";
import CRG_Gala from "./pages/CRG_Gala";
import CRG_Tipico from "./pages/CRG_Tipico";
import CRG_Barra from "./pages/CRG_Barra";
import Gracias from "./pages/Gracias";
// import Carrusel2 from "./Carrusel2";
import Navbar from "./components/Navbar";
import Navbar2 from "./components/Navbar2";
import Reporte from "./pages/Reporte";
import { PDFViewer } from "@react-pdf/renderer";
// import Espera from "./components/Espera";
import Footer from "./components/Footer";
import "./style.scss";
import TablaNotario from "./pages/TablaNotario";
import PanelAdmin from "./pages/PanelAdmin";
import Desempate from "./pages/Desempate";
// import SlideShow from "./Carrusel2";

const Layout = () => {
  return (
    <>
      <Outlet />
    </>
  );
};

const Layout2 = () => {
  return (
    <>
      <Navbar />
      <Outlet />
    </>
  );
};

const router = createBrowserRouter([
  {
    path: "/",

    element: <Layout />,
    children: [
      {
        path: "/",
        element: <Login />,
      },
      {
        path: "/TrajeTipico",
        element: <TTipico />,
      },
      {
        path: "/TrajeGala",
        element: <TGala />,
      },
      {
        path: "/Desempate",
        element: <Desempate />,
      },
      {
        path: "/Preguntas",
        element: <Preguntas />,
      },
      {
        path: "/Carrusel",
        element: <Carrusel />,
      },
      {
        path: "/CRG_Gala",
        element: <CRG_Gala />,
      },
      {
        path: "/CRG_Tipico",
        element: <CRG_Tipico />,
      },
      {
        path: "/CRG_Barra",
        element: <CRG_Barra />,
      },
      {
        path: "/Gracias",
        element: <Gracias />,
      }
    ],
    
  },
  {
    path: "/",
    
    element: <Layout2 />,
    children: [
      {
        path: "/TablaNotario",
        element: <TablaNotario />,
      },
      {
        path: "/register",
        element: <Register />,
      
      },
      {
        path: "/Reporte",
        element: <Reporte />
      },
      {
        path: "/PanelAdmin",
        element: <PanelAdmin />
      }  
    ],
  },
  {
    path: "/login",
    element: <Login />,
  },
  {
    path: "/register",
    element: <Register />,
  
  },
  // {
  //   path: "/slideshow",
  //   element: <SlideShow />,
  
  // },
]);



function App() {
  return (
    <div className="app">
      <div className="container">
        <RouterProvider router={router} />
      </div>
    </div>
  );
}

export default App;
