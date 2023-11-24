import { AngularFirestore} from '@angular/fire/compat/firestore';
export interface UserServices {
    uid:string;
    email:string;
    displayName: string;
    photoURL: string;
    admUser:boolean;
    emailVerified: boolean;
}
export class AdmUser{
    constructor(
    ){ }

}

