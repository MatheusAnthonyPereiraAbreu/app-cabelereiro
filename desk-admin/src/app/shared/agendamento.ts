import { Data } from "@angular/router";

export interface Agendamento {
    $key:string;
    dataTime:Data;
    nomeCliente:string;
    servico:string;
    cabelereiro:string
}
