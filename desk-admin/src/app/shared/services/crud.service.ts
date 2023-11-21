import { Injectable } from '@angular/core';
import { Agendamento } from '../agendamento';
import {
  AngularFireDatabase,
  AngularFireList,
  AngularFireObject,
} from '@angular/fire/compat/database';
@Injectable({
  providedIn: 'root',
})
export class CrudService {
  agendamentosRef: AngularFireList<any>;
  agendamentoRef: AngularFireObject<any>;
  constructor(private db: AngularFireDatabase) {}
  // Create Student
  AddAgendamento(agenda: Agendamento) {
    this.agendamentosRef.push({
      key: agenda.$key,
      data: agenda.dataTime,
      nome: agenda.nomeCliente,
      service: agenda.servico,
      profi:agenda.cabelereiro
    });
  }
  // Fetch Single Student Object
  GetAgendamento(id: string) {
    this.agendamentoRef = this.db.object('agendamentos-list/' + id);
    return this.agendamentoRef;
  }
  // Fetch Students List
  GetAgendamentoList() {
    this.agendamentosRef = this.db.list('agendamentos-list');
    return this.agendamentosRef;
  }
  // Update Student Object
  UpdateAgendamento(agenda: Agendamento) {
    this.agendamentoRef.update({
      key: agenda.$key,
      data: agenda.dataTime,
      nome: agenda.nomeCliente,
      service: agenda.servico,
      profi:agenda.cabelereiro,
    });
  }
  // Delete Student Object
  DeleteAgendamento(id: string) {
    this.agendamentoRef = this.db.object('students-list/' + id);
    this.agendamentoRef.remove();
  }
}