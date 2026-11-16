
export const obtenersalud = (_req,res) => {
    res.status(200).json({
        estado : "ok",
        application: "CampusCloud API",
        mensaje: "El servidor esta funcionando"
    })
};