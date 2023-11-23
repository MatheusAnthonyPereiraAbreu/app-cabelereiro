import { Component, OnInit } from '@angular/core';
import { CrudService } from 'src/app/shared/services/crud.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { agendamentos } from 'src/app/shared/agendamento';

@Component({
  selector: 'app-add-agendamento',
  templateUrl: './add-agendamento.component.html',
  styleUrls: ['./add-agendamento.component.scss']
})
export class AddAgendamentoComponent implements OnInit {
  public agendamentoForm: FormGroup;

  constructor(
    public crudApi: CrudService,
    public fb: FormBuilder,
    public toastr: ToastrService
  ) {}

  ngOnInit() {
    this.agendaForm();
    this.agendamentoForm.get('dataAtual').setValue(new Date().toISOString().split('T')[0]);
    this.crudApi.GetAgendamentoList(); // Não está claro o que você deseja fazer com essa chamada
  }

  agendaForm() {
    this.agendamentoForm = this.fb.group({
      nomeCliente: ['', [Validators.required, Validators.minLength(2)]],
      dataAtual: [''],
      service: [''],
      cabelereiro: [''],
      horario: [''],
      id:['']
    });
  }

  get nomeCliente() {
    return this.agendamentoForm.get('nomeCliente');
  }

  get dataAtual() {
    return this.agendamentoForm.get('dataAtual');
  }

  get horario() {
    return this.agendamentoForm.get('horario');
  }

  get service() {
    return this.agendamentoForm.get('service');
  }

  get cabelereiro() {
    return this.agendamentoForm.get('cabelereiro');
  }
  get id(){
    return this.agendamentoForm.get('id');
  }

  ResetForm() {
    this.agendamentoForm.reset();
  }

  submitAgendamentoData() {
    const agendamentoData : agendamentos = {
      nomeCliente: this.agendamentoForm.value.nomeCliente,
      data: this.agendamentoForm.value.dataAtual,
      servico: this.agendamentoForm.value.service,
      cabelereiro: this.agendamentoForm.value.cabelereiro,
      horario: this.agendamentoForm.value.horario,
    };

    this.crudApi.AddAgendamento(agendamentoData);
    
    this.toastr.success(
      this.agendamentoForm.controls['nomeCliente'].value + ' successfully added!'
    );
    this.ResetForm();
  }
}
