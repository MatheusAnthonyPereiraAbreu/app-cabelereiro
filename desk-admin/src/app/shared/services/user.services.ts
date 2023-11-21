import { AngularFirestore} from '@angular/fire/compat/firestore';
export interface UserServices {
    uid:string;
    email:string;
    displayName: string;
    photoURL: string;
    emailVerified: boolean;

}
export class AdmUser{
    constructor(
        private firestore: AngularFirestore,
    ){ }
    getUser(uid: string) {
        return this.firestore.doc(`users/${uid}`).get();
      }
}

