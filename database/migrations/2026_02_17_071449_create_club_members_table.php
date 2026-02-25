<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
public function up(): void

{

    Schema::create('club_members', function (Blueprint $table) {

        $table->foreignUuid('club_id')->constrained()->onDelete('cascade');

        $table->foreignUuid('user_id')->constrained()->onDelete('cascade');

        $table->string('role', 20)->default('member');

        $table->timestamps();

        

        $table->primary(['club_id', 'user_id']);

    });

}



public function down(): void

{

    Schema::dropIfExists('club_members');

}
};
